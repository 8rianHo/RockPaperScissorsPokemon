//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Brian Ho on 07/02/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //Pokemon background
    @IBOutlet weak var longBarText: UIButton!
    @IBOutlet weak var longBarLbl: UILabel!
    @IBOutlet weak var myHPbar: UIView!
    @IBOutlet weak var opponentHPbar: UIView!
    @IBOutlet weak var firstMessageBtn: UIButton!
    @IBOutlet weak var secondMessageBtn: UIButton!
    
    @IBOutlet weak var myHPprogress: UIProgressView!
    @IBOutlet weak var myOppProgress: UIProgressView!
    
    // move images
    @IBOutlet weak var myMoveImage: UIImageView!
    @IBOutlet weak var oppMoveImage: UIImageView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var oakImage: UIImageView!
    
    // medium bar
    @IBOutlet weak var menuBar: UIImageView!
    @IBOutlet weak var fightBtn: UIButton!
    @IBOutlet weak var itemBtn: UIButton!
    @IBOutlet weak var runItem: UIButton!
    @IBOutlet weak var arrowBtn: UIImageView!
    
    // item bar
    @IBOutlet weak var itemList: UIImageView!
    @IBOutlet weak var itemCancelBtn: UIButton!
    @IBOutlet weak var PotionBtn: UIButton!
    @IBOutlet weak var PotionCount: UILabel!
    
    
    // fight bar
    @IBOutlet weak var fightBar: UIImageView!
    @IBOutlet weak var arrow2btn: UIImageView!
    @IBOutlet weak var rockBtn: UIButton!
    @IBOutlet weak var paperBtn: UIButton!
    @IBOutlet weak var scissorsBtn: UIButton!
    @IBOutlet weak var fightStack: UIStackView!
    
    @IBOutlet weak var myScoreLbl: UILabel!
    @IBOutlet weak var originalScoreLbl: UILabel!
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var oak_itemCount: UILabel!
    
    var passed_name:String = ""
    var passed_playerHP:Double = 0.0
    var passed_oakHP:Double = 0.0
    var passed_oakItems:Int = 0
    var passed_playerItems:Int = 0
    
    var player:Player!
    var oak:Player!
    var viewT = View()
    var battle:Battle!
    
    @IBAction func runBtnTouch(_ sender: Any) {

        viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:true)
        let text = "Got away safely!"
        viewT.fightBtnTouch(longBarText: longBarText, longBarLbl: longBarLbl, string: text, enable: true)
        
    }
    
    @IBAction func itemBtnTouch(_ sender: Any) {
        
        itemList.isHidden = false
        itemCancelBtn.isHidden = false
        PotionBtn.isHidden = false
        PotionCount.isHidden = false
        
        viewT.setPotionText(lbl: PotionCount, items: player.item_bag)
        
    }
    @IBAction func itemCancelDidTouch(_ sender: Any) {
        
        viewT.itemListToggle(itemList: itemList, cancel: itemCancelBtn, potion: PotionBtn, lbl: PotionCount, toggle: true)
    }
    @IBAction func potionDidTouch(_ sender: Any) {
        
        viewT.itemListToggle(itemList: itemList, cancel: itemCancelBtn, potion: PotionBtn, lbl: PotionCount, toggle: false)
        
        viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:true)
        
        firstMessageBtn.isEnabled = true
        if battle.playerPotionUsage() == -1 {
            viewT.itemListToggle(itemList: itemList, cancel: itemCancelBtn, potion: PotionBtn, lbl: PotionCount, toggle: true)
            viewT.potion(hp: myHPprogress, who: player)
            myScoreLbl.text = "\(player.score)"

        } else {
            viewT.itemListToggle(itemList: itemList, cancel: itemCancelBtn, potion: PotionBtn, lbl: PotionCount, toggle: true)
            battle.message1 = "Why are you trying to break my game?"
        }
        longBarLbl.text? = battle.message1
    }
    
    
    @IBAction func fightBtnTouch(_ sender: Any) {
        
        viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:true)
        viewT.fightBtnTouch(longBarText: longBarText, longBarLbl: longBarLbl, string: "", enable: false)
        
        viewT.fightBar(fightBar: fightBar, fightBtn: fightBtn, arrow2Btn: arrow2btn, fightStack: fightStack, hidden: false)
        
    }
    
    @IBAction func messageLblTouch(_ sender: Any) {
        
        let choice = viewT.messageLbl(longBarLbl: longBarLbl)
        if choice == 1 {
            
            dismiss(animated: true, completion: nil)
        } else if choice == 2 {
            
            dismiss(animated: true, completion: nil)
        } else if choice == 3 {
            //menuBarVisible(hidden: false)
            viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:false)

        }
        
    }
    
    @IBOutlet weak var muteButton: UIButton!
    
    @IBOutlet weak var unmuteButton: UIButton!
    
    @IBAction func toggleMute(_ sender: Any) {
        muteButton.isHidden = true
        unmuteButton.isHidden = false
        
    }
    @IBAction func toggleUnmute(_ sender: Any) {
        muteButton.isHidden = false
        unmuteButton.isHidden = true
        
    }

    @IBAction func afterFirstMessage(_ sender: Any) {
        
        let next_msg = battle.afterFirstMessage()
        viewT.setBattleImage2(pMoveImage: myMoveImage, oMoveImage: oppMoveImage, pImage: myImage, oImage: oakImage, word: next_msg, name: player.name)
        if battle.message1.contains("POTION"){
            oak_itemCount.isHidden = true
        }
        firstMessageBtn.isEnabled = false
        secondMessageBtn.isEnabled = true
        longBarLbl.text? = next_msg
        
    }
    
    @IBAction func afterSecondMessage(_ sender: Any) {
        
        let string = battle.afterSecondMessage()
        viewT.checkWhoLost(string: string, hp1: myHPprogress, hp2: myOppProgress, who1: player, who2: oak)

        myScoreLbl.text = "\(player.score)"
        // resets the battle scene i.e oak and ash visible
        viewT.reset(longBarLbl: longBarLbl, btn: secondMessageBtn, pMoveImage: myMoveImage, oMoveImage: oppMoveImage, pImage: myImage, oImage: oakImage)
        
        viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:false)

        let number = battle.endGame()
        let check = viewT.endGame(check: number, name: player, longBarText: longBarText, longBarLbl: longBarLbl)
        
        if check == 1 {
            viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:true)
        } else if check == 2{
            viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:true)
        } else if check == 3{
            viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:true)
        }
        
        
    }
    
    // FIGHT BUTTON TOUCHED
    @IBAction func myMoveMethod(sender:UIButton){
        
        let myMoveNumber = sender.tag
        
        // gets the battle sentence & correct images
        let outcome = battle.player_move(number: myMoveNumber)
        if battle.message1.contains("HOLD ON! NESSA used POTION") {
            myOppProgress.setProgress(Float(oak.progress), animated: true)
            
            oak_itemCount.isHidden = false
            oak_itemCount.text = ("POTION x\(oak.item_bag)")
        }
        viewT.setBattleImage1(pMoveImage: myMoveImage, oMoveImage: oppMoveImage, pImage: myImage, oImage: oakImage, word: outcome, name: player.name)
        
        firstMessageBtn.isEnabled = true
        longBarLbl.text? = outcome
        
        viewT.fightBar(fightBar: fightBar, fightBtn: fightBtn, arrow2Btn: arrow2btn, fightStack: fightStack, hidden: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let set_player = Player(name:passed_name, start:passed_playerHP, hp:passed_playerHP, score:Int(passed_playerHP), items:passed_playerItems)
        player = set_player
        let set_oak = Player(name:"NESSA", start:passed_oakHP, hp:passed_oakHP, score:Int(passed_oakHP), items:passed_oakItems)
        oak = set_oak
        
        battle = Battle(player: player, opponent: oak)
        
        viewT.setUpLabels(name: playerName, score: myScoreLbl, original: originalScoreLbl, who: player, longBar: longBarLbl)
        viewT.setupScreen(pMoveImage: myMoveImage, oMoveImage: oppMoveImage, myHP: myHPprogress, oHP: myOppProgress, player: player, oak: oak)
        
    }

}

