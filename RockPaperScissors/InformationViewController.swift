//
//  InformationViewController.swift
//  RockPaperScissors
//
//  Created by Brian Ho on 22/09/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    
    @IBAction func closeBtnDidTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
