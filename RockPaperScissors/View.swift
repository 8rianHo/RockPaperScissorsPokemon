//
//  View.swift
//  RockPaperScissors
//
//  Created by Brian Ho on 15/06/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import UIKit

class View: UIView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // fight bar setup
    func fightBar(fightBar:UIImageView, fightBtn:UIButton, arrow2Btn:UIImageView, fightStack:UIStackView, hidden:Bool){
        fightBar.isHidden = hidden
        fightBtn.isHidden = hidden
        arrow2Btn.isHidden = hidden
        fightStack.isHidden = hidden
    }
    
    func messageLbl(longBarLbl:UILabel) -> Int {
        var num = 0
        if longBarLbl.text == "Got away safely!" {
            num = 1
        } else if (longBarLbl.text?.contains("KNOCKED"))! || (longBarLbl.text?.contains("DEFEATED"))! || (longBarLbl.text?.contains("DRAW!"))! {
            longBarLbl.text = "TAP TO BATTLE AGAIN"
        } else if (longBarLbl.text?.contains("TAP TO BATTLE AGAIN"))!{
            num = 2
        } else {
            longBarLbl.text? = ""
            num = 3
        }
        return num
    }

    func menuBarSet(menuBar:UIImageView, fightBtn:UIButton, itemBtn:UIButton, pkmnBtn:UIButton, runBtn:UIButton, arrow2Btn:UIImageView, hidden:Bool){
        menuBar.isHidden = hidden
        fightBtn.isHidden = hidden
        itemBtn.isHidden = hidden
        pkmnBtn.isHidden = hidden
        runBtn.isHidden = hidden
        arrow2Btn.isHidden = hidden
    }
    
    func fightBtnTouch(longBarText:UIButton, longBarLbl:UILabel, string:String, enable:Bool){
        longBarText.isEnabled = enable
        longBarLbl.text = string
    }
    
    func setBattleImage1(pMoveImage:UIImageView, oMoveImage:UIImageView, pImage:UIImageView, oImage:UIImageView, word:String, name:String){
        // to set the right battle images
        switch word {
        case "HOLD ON! OAK used POTION":
            break
        case "BOTH used ROCK SMASH!":
            pMoveImage.image = UIImage(named: "rock")
            oMoveImage.image = UIImage(named: "rock")
            
            pImage.isHidden = true
            oImage.isHidden = true
            break
        case "OAK used X-SCISSOR! It's not very effective...":
            
            oMoveImage.image = UIImage(named: "scissors-1")
            oImage.isHidden = true
            break
        case "\(name) used ROCK SMASH! It's not very effective...":
            
            pMoveImage.image = UIImage(named: "rock")
            pImage.isHidden = true
            break
        case "BOTH used PAPER CUT!":
            
            pMoveImage.image = UIImage(named: "paper")
            oMoveImage.image = UIImage(named: "paper")
            
            pImage.isHidden = true
            oImage.isHidden = true
            break
        case "\(name) used PAPER CUT! It's not very effective...":
            
            pMoveImage.image = UIImage(named: "paper")
            pImage.isHidden = true
            break
        case "OAK used ROCK SMASH! It's not very effective...":
            
            oMoveImage.image = UIImage(named: "rock")
            oImage.isHidden = true
            break
        case "BOTH used X-SCISSOR!":
            
            pMoveImage.image = UIImage(named: "scissors-1")
            oMoveImage.image = UIImage(named: "scissors-1")
            
            pImage.isHidden = true
            oImage.isHidden = true
            break
        case "OAK used PAPER CUT! It's not very effective...":
            
            oMoveImage.image = UIImage(named: "paper")
            oImage.isHidden = true
            break
        case "\(name) used X-SCISSOR! It's not very effective...":
            
            pMoveImage.image = UIImage(named: "scissors-1")
            pImage.isHidden = true
            break
        default:
            break
        }
    }
    
    func setBattleImage2(pMoveImage:UIImageView, oMoveImage:UIImageView, pImage:UIImageView, oImage:UIImageView, word:String, name:String){
        // to set the right battle images
        switch word {
            
        case "OAK used X-SCISSOR! It's super effective!":
            oImage.isHidden = true
            oMoveImage.image = UIImage(named: "scissors-1")
            
            break
        case "OAK used ROCK SMASH! It's super effective!":
            oImage.isHidden = true
            oMoveImage.image = UIImage(named: "rock")
            
            break
        case "OAK used PAPER CUT! It's super effective!":
            oImage.isHidden = true
            oMoveImage.image = UIImage(named: "paper")
            
            break
        case "\(name) used ROCK SMASH! It's super effective!":
            pImage.isHidden = true
            pMoveImage.image = UIImage(named: "rock")
            
            break
        case "\(name) used PAPER CUT! It's super effective!":
            pImage.isHidden = true
            pMoveImage.image = UIImage(named: "paper")
            
            break
        case "\(name) used X-SCISSOR! It's super effective!":
            pImage.isHidden = true
            pMoveImage.image = UIImage(named: "scissors-1")
            
            break
        default:
            break
        }
    }
    
    func checkWhoLost(string:String, hp1:UIProgressView, hp2:UIProgressView, who1: Player, who2: Player){
        if string.contains("OAK"){
            hpBar(hp: hp2, who: who2)
            
        } else if string.contains("\(who1.name)"){
            hpBar(hp: hp1, who: who1)
        } else if string.contains("confusion"){
            hpBar(hp: hp2, who: who2)
            
            hpBar(hp: hp1, who: who1)
        }
    }
    func hpBar(hp:UIProgressView, who:Player){
        let damage = 1.1 / who.startHP
        who.progress = who.progress - damage
        hp.setProgress(Float(who.progress), animated: true)
    }
    
    func endGame(check:Int, name:Player, longBarText:UIButton, longBarLbl:UILabel) -> Int{
        var num = 0
        switch check{
        case 1:
            longBarText.isEnabled = true
            name.score = 0
            longBarLbl.text? = "OAK WINS! \(name.name) WAS KNOCKED OUT!"
            num = 1
            break
        case 2:
            longBarText.isEnabled = true
            name.score = 0
            longBarLbl.text? = "\(name.name) WINS! PROFESSOR OAK was DEFEATED!"
            num = 2
            break
        case 3:
            longBarText.isEnabled = true
            name.score = 0
            longBarLbl.text? = "DRAW!"
            num = 3
            break
        default:
            break
        }
        return num
    }
    
    func reset(longBarLbl:UILabel, btn:UIButton, pMoveImage:UIImageView, oMoveImage:UIImageView, pImage:UIImageView, oImage:UIImageView){
        
        longBarLbl.text? = ""
        btn.isEnabled = false
        pMoveImage.image = nil
        oMoveImage.image = nil
        pImage.isHidden = false
        oImage.isHidden = false
    }
    
    func setPotionText(lbl:UILabel, items:Int){
        lbl.text = "x\(items)"
    }
    func potion(hp:UIProgressView, who:Player){
        hp.setProgress(Float(who.progress), animated: true)
        who.item_bag -= 1
    }
    
    func itemListToggle(itemList:UIImageView, cancel:UIButton, potion:UIButton, lbl:UILabel, toggle:Bool){
        itemList.isHidden = toggle
        cancel.isHidden = toggle
        potion.isHidden = toggle
        lbl.isHidden = toggle
    }

    func setUpLabels(name:UILabel, score:UILabel, original:UILabel, who:Player, longBar:UILabel){
        name.text? = who.name
        score.text = "\(who.score)"
        original.text = "\(who.score)"
        
        longBar.text = "PROFESSOR OAK wants to fight!"
    }
    func setupScreen(pMoveImage:UIImageView, oMoveImage:UIImageView, myHP:UIProgressView, oHP:UIProgressView, player:Player, oak:Player){
        pMoveImage.image = nil
        oMoveImage.image = nil
        
        myHP.transform = myHP.transform.scaledBy(x: 1, y: 4)
        myHP.setProgress(Float(player.playerHP), animated: true)
        oHP.transform = oHP.transform.scaledBy(x: 1, y: 4)
        oHP.setProgress(Float(oak.playerHP), animated: true)
    }

}
