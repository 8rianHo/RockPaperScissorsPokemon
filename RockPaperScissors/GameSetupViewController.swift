//
//  GameSetupViewController.swift
//  RockPaperScissors
//
//  Created by Brian Ho on 10/05/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import UIKit

class GameSetupViewController: UIViewController {
    
    @IBOutlet weak var player_name: UITextField!
    @IBOutlet weak var label_playerHP: UILabel!
    @IBOutlet weak var label_oakHP: UILabel!
    @IBOutlet weak var HPlabel_player: UILabel!
    @IBOutlet weak var HPlabel_oak: UILabel!
    
    var chosen_playerHP:Int = 5
    var chosen_oakHP:Int = 5
    var player_test = Player()
    var oak_test = Player()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        HPlabel_player.text? = chosen_playerHP.description
        HPlabel_oak.text? = chosen_oakHP.description
        
    }
    
    @IBAction func increment_playerHP(_ sender: Any) {
        let hp = chosen_playerHP
        
        if hp < 20 {
        chosen_playerHP = chosen_playerHP+1
        HPlabel_player.text? = chosen_playerHP.description
        }
        
    }
    @IBAction func decrement_playerHP(_ sender: Any) {
        let hp = chosen_playerHP
        
        if hp > 3 {
        chosen_playerHP = chosen_playerHP-1
        HPlabel_player.text? = chosen_playerHP.description
        }
    }
    
    @IBAction func increment_oakHP(_ sender: Any) {
        let hp = chosen_oakHP
        
        if hp < 20 {
            chosen_oakHP = chosen_oakHP+1
            HPlabel_oak.text? = chosen_oakHP.description
        }
    }
    @IBAction func decrement_oakHP(_ sender: Any) {
        let hp = chosen_oakHP
        
        if hp > 3 {
            chosen_oakHP = chosen_oakHP-1
            HPlabel_oak.text? = chosen_oakHP.description
        }
    }
    
    @IBAction func infoBtnDidTouch(_ sender: Any) {
        performSegue(withIdentifier: "infoSegue", sender: nil)
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "startSegue" {
            let valid_name = player_name.text
            let oak_test = player_name.text?.uppercased()
            if (valid_name?.isEmpty)! || (valid_name?.contains(" "))! || (oak_test?.contains("NESSA"))! || ((valid_name?.characters.count)! > 6) {
                player_name.text = ""
                player_name.placeholder = "valid name please"
                return false
            }
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "startSegue" {
            
            let destinationVC = segue.destination as! ViewController
            let pass_playername = player_name.text?.uppercased()
            let playerHP = chosen_playerHP
            let oakHP = chosen_oakHP
            destinationVC.passed_name = pass_playername!
            destinationVC.passed_playerHP = Double(playerHP)
            destinationVC.passed_oakHP = Double(oakHP)
            destinationVC.passed_playerItems = player_test.start_items()
            destinationVC.passed_oakItems = oak_test.start_items()
            
        }
        
    }

}
    

