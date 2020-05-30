//
//  NewsInformationVC.swift
//  vea
//
//  Created by sid on 5/30/20.
//  Copyright © 2020 ritvik. All rights reserved.
//

import UIKit

class NewsInformationVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var articleTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        fillData()
    }
    
    func fillData(){
        titleLabel.text = ViewController.titles[ViewController.currentIndex]
        authorLabel.text = ViewController.authors[ViewController.currentIndex]
        datelabel.text = ViewController.dates[ViewController.currentIndex]
        articleTextView.text = ViewController.text[ViewController.currentIndex]
    }
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {

                switch swipeGesture.direction {
                case .right:
                    UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                        let transition: CATransition = CATransition()
                        transition.duration = 0.25
                        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                        transition.type = CATransitionType.reveal
                        transition.subtype = CATransitionSubtype.fromLeft
                        self.view.window!.layer.add(transition, forKey: nil)
                        self.dismiss(animated: false, completion: nil)
                    }, completion: nil)
                default:
                    break
                }
            }
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
