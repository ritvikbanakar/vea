//
//  ViewController.swift
//  vea
//
//  Created by ritvik on 5/30/20.
//  Copyright © 2020 ritvik. All rights reserved.
//

import UIKit
import FirebaseDatabase
class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var subText1: UILabel!
    @IBOutlet weak var subText2: UILabel!
    let height = UIScreen.main.bounds.height
    var positionTop: CGAffineTransform!
    var positionCenter: CGAffineTransform!
    var positionBottom: CGAffineTransform!
    
    static var titles: [String] = []
    static var authors: [String] = []
    static var dates: [String] = []
    static var text: [String] = []
    static var sub: [String] = []
    static var url: [String] = []
    static var currentIndex = 0
    static var savedIndex: [Int]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        read()
        
        positionTop = CGAffineTransform(translationX: 0, y: -height)
        positionBottom = CGAffineTransform(translationX: 0, y: height)
        positionCenter = CGAffineTransform.identity
        
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
        let ref = Database.database().reference()
        ref.child("articles").observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                let values = Array(data.values)
                print(values)
                let valueDict  = values as! [[String: Any]]
                print("~~~~~~~~~~~~~~~~~`")
                print("\(valueDict) \n\n")
                
                for miniArray in valueDict{
                    ViewController.titles.append(miniArray["the_headline"] as! String)
                    ViewController.url.append(miniArray["the_url"] as! String)
                    ViewController.sub.append(miniArray["the_news_desk"] as! String)
                    ViewController.sub.append(miniArray["the_date"] as! String)
                }
                self.setTitles(title1Index: ViewController.currentIndex, title2Index: ViewController.currentIndex+1)



            }
        }) { (error) in  print(error.localizedDescription) }
    }
    func setUp(){
        title2.transform = positionBottom
        subText2.transform = positionBottom
    }
    
    func setTitles(title1Index: Int, title2Index: Int){
        title1.text = ViewController.titles[title1Index]
        title2.text = ViewController.titles[title2Index]
        subText1.text = ViewController.sub[title1Index]
        subText2.text = ViewController.sub[title2Index]
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
                UIView.animate(withDuration: 0.3, animations: {
                    self.title1.transform = self.positionCenter
                    self.subText1.transform = self.positionCenter
                    self.title2.transform = self.positionBottom
                    self.subText2.transform = self.positionBottom
                })
                
            case .up:
                if(ViewController.currentIndex == ViewController.titles.count-1){ break }
                ViewController.currentIndex += 1
                UIView.animate(withDuration: 0.3, animations: {
                    self.title1.transform = self.positionTop
                    self.subText1.transform = self.positionTop
                    self.title2.transform = self.positionCenter
                    self.subText2.transform = self.positionCenter
                }, completion: {
                    (value: Bool) in
                    self.title1.transform = self.positionCenter
                    self.subText1.transform = self.positionCenter
                    self.title2.transform = self.positionBottom
                    self.subText2.transform = self.positionBottom
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

