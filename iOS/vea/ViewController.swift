//
//  ViewController.swift
//  vea
//
//  Created by ritvik on 5/30/20.
//  Copyright © 2020 ritvik. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftSoup
class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage1: UIImageView!
    @IBOutlet weak var backgroundImage2: UIImageView!
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var subText1: UILabel!
    @IBOutlet weak var subText2: UILabel!
    let height = UIScreen.main.bounds.height
    var positionTop: CGAffineTransform!
    var positionCenter: CGAffineTransform!
    var positionBottom: CGAffineTransform!
    var positionTop2: CGAffineTransform!
    var positionBottom2: CGAffineTransform!
    var para: [String] = []

    static var titles: [String] = []
    static var authors: [String] = []
    static var dates: [String] = []
    static var text: [[String]] = [[]]
    static var text2: [String] = []
    static var sub: [String] = []
    static var url: [String] = []
    static var currentIndex = 0
    static var savedIndex: [Int]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        read()
        
        
        
        positionTop = CGAffineTransform(translationX: 0, y: -height/2)
        positionBottom = CGAffineTransform(translationX: 0, y: height/2)
        positionCenter = CGAffineTransform.identity
        positionTop2 = CGAffineTransform(translationX: 0, y: -height)
        positionBottom2 = CGAffineTransform(translationX: 0, y: height)
        
        backgroundImage1.contentMode = .scaleAspectFill
        backgroundImage2.contentMode = .scaleAspectFill
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        setUp()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    func read(){
        var dataString = ""
        let ref = Database.database().reference()
        ref.child("articles").observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                let values = Array(data.values)
                
                let valueDict  = values as! [[String: Any]]
             
                
                for miniArray in valueDict{
                    ViewController.titles.append(miniArray["the_headline"] as! String)
                    ViewController.url.append(miniArray["the_url"] as! String)
                    ViewController.sub.append(miniArray["the_news_desk"] as! String)
                    print(miniArray["the_headline"])
                    var delimiter = "T"
                    var newstr = miniArray["the_date"] as! String
                    var token = newstr.components(separatedBy: delimiter)
                    var newDate = token[0]
                    ViewController.dates.append(newDate)
                }
                
                self.setTitles(title1Index: ViewController.currentIndex, title2Index: ViewController.currentIndex+1)
                for web in ViewController.url {
                    //print(URL(string: web)!)
                    
                    //print(ViewController.authors)
                    //print("\n\n\n")
                    let html = try! String(contentsOf: URL(string: web)!, encoding: .utf8)
                    do {
                       let doc: Document = try SwiftSoup.parseBodyFragment(html)
                        let body: Elements = try doc.getElementsByTag("p")
                         let authorStuff: [Element] = try doc.select("meta").array()
                        for name in authorStuff {
                            if(try name.attr("name") == "byl") {
                                ViewController.authors.append(try name.attr("content"))
                            }
                        }
                        for p in body {
                            var check = try p.text()
                           

                            if(check != "Advertisement" && check != "Supported by"
                                && !check.hasPrefix("By")) {
                              
                                dataString += try p.text() + "\n\n\n\t"
                            }
                        }
                        ViewController.text2.append(dataString)
                        dataString = ""
                    } catch Exception.Error(let type, let message) {
                        print(message)
                    } catch {
                        print("error")
                    }
                 
                }

            }
        }) { (error) in  print(error.localizedDescription) }
    }
    func setUp(){
        title2.transform = positionBottom
        subText2.transform = positionBottom
        backgroundImage2.transform = positionBottom2
    }
    
    func setTitles(title1Index: Int, title2Index: Int){
        title1.text = ViewController.titles[title1Index]
        title2.text = ViewController.titles[title2Index]
        print(ViewController.titles[title2Index])
        subText1.text = ViewController.sub[title1Index]
        subText2.text = ViewController.sub[title2Index]
        backgroundImage1.image = UIImage(named: title1.text!)
        backgroundImage2.image = UIImage(named: title2.text!)
        

    }
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .down:
                if(ViewController.currentIndex == 0){ break }
                setTitles(title1Index: ViewController.currentIndex-1, title2Index: ViewController.currentIndex)
                ViewController.currentIndex -= 1
                title1.transform = positionTop
                subText1.transform = positionTop
                title2.transform = positionCenter
                subText2.transform = positionCenter
                backgroundImage1.transform = positionTop2
                backgroundImage2.transform = positionCenter
//               self.backgroundImage1.frame = CGRect(x: 0, y: self.backgroundImage1.frame.size.height, width: self.backgroundImage1.frame.size.width, height: self.backgroundImage1.frame.size.height)
//               self.backgroundImage2.frame = CGRect(x: 0, y: 0, width: self.backgroundImage2.frame.size.width, height: self.backgroundImage2.frame.size.height)
                self.backgroundImage1.alpha = 1
                self.backgroundImage2.alpha = 1
                self.title1.alpha = 0
                self.subText1.alpha = 0
                self.title2.alpha = 1
                self.subText2.alpha = 1
                UIView.animate(withDuration: 0.3, animations: {
                    self.title1.transform = self.positionCenter
                    self.title1.alpha = 1
                    self.subText1.alpha = 1
                    self.title2.alpha = 0
                    self.subText2.alpha = 0
                    self.subText1.transform = self.positionCenter
                    self.title2.transform = self.positionBottom
                    self.subText2.transform = self.positionBottom
                    self.backgroundImage1.transform = self.positionCenter
                    self.backgroundImage2.transform = self.positionBottom2
                    self.backgroundImage1.alpha = 1
                    self.backgroundImage2.alpha = 1
                })
                
            case .up:
                if(ViewController.currentIndex == ViewController.titles.count-1){ break }
                ViewController.currentIndex += 1
                UIView.animate(withDuration: 0.3, animations: {
                    self.title1.transform = self.positionTop
                    self.subText1.transform = self.positionTop
                    self.backgroundImage1.transform = self.positionTop2
                    self.title2.transform = self.positionCenter
                    self.subText2.transform = self.positionCenter
                    self.backgroundImage2.transform = self.positionCenter
                    self.title1.alpha = 0
                    self.subText1.alpha = 0
                    self.title2.alpha = 1
                    self.subText2.alpha = 1
                    self.backgroundImage1.alpha = 1
                    self.backgroundImage2.alpha = 1
                    
                    
                }, completion: {
                    (value: Bool) in
                    self.title1.transform = self.positionCenter
                    self.subText1.transform = self.positionCenter
                    self.backgroundImage1.transform = self.positionCenter
                    self.title2.transform = self.positionBottom
                    self.subText2.transform = self.positionBottom
                    self.backgroundImage2.transform = self.positionBottom2
                    self.title1.alpha = 1
                    self.subText1.alpha = 1
                    self.title2.alpha = 0
                    self.subText2.alpha = 0
                    self.backgroundImage1.alpha = 1
                    self.backgroundImage2.alpha = 1
                    if(ViewController.currentIndex < ViewController.titles.count-2){
                        self.setTitles(title1Index: ViewController.currentIndex, title2Index: ViewController.currentIndex+1)
                    } else {
                        self.setTitles(title1Index: ViewController.currentIndex, title2Index: ViewController.currentIndex)
                    }
                })
               
                
            case .left:
                performSegue(withIdentifier: "custom1", sender: nil)
//                let newvc = self.storyboard?.instantiateViewController(withIdentifier: "article") as! UIViewController
//
//                newvc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//
//                self.present(newvc, animated: true, completion: nil)
            default:
                break
            }
        }
    }


}

