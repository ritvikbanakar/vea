//
//  GetStartedVC.swift
//  vea
//
//  Created by Vidit Agrawal on 5/31/20.
//  Copyright © 2020 ritvik. All rights reserved.
//

import UIKit

class GetStartedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func getStartedPressed(_ sender: Any) {
        performSegue(withIdentifier: "popUp", sender: nil)
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
