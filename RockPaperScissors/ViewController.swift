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
    @IBOutlet weak var pkmnBtn: UIButton!
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
    
    // MARK: testing
    @IBOutlet weak var playerName: UILabel!
    var passed_name:String = ""
    var passed_playerHP:Double = 0.0
    var passed_oakHP:Double = 0.0
    var passed_oakItems:Int = 0
    var passed_playerItems:Int = 0
    @IBOutlet weak var oak_itemCount: UILabel!
    
    var player:Player!
    var oak:Player!
    var items = Item()
//    player.startHP = passed_playerHP
//    player.playerHP = passed_playerHP
//    player.score = Int(passed_playerHP)
    
    var myMoveNumber = 0
    var opponentMove = ""
    var opponentNumber = 0
    var randomNumber = 0
    
    var sound = Sound()
    
    @IBAction func runBtnTouch(_ sender: Any) {
        
        sound.runaway.play()
        viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, pkmnBtn:pkmnBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:true)
        let text = "Got away safely!"
        viewT.fightBtnTouch(longBarText: longBarText, longBarLbl: longBarLbl, string: text, enable: true)
        sound.song.stop()
        
    }
    
    @IBAction func itemBtnTouch(_ sender: Any) {
        
        itemList.isHidden = false
        itemCancelBtn.isHidden = false
        PotionBtn.isHidden = false
        PotionCount.isHidden = false
        
        // should not be computed here
//        PotionCount.text? = "x\(passed_playerItems)"
        viewT.setPotionText(lbl: PotionCount, items: player.item_bag)
        
    }
    @IBAction func itemCancelDidTouch(_ sender: Any) {
        
//        itemList.isHidden = true
//        itemCancelBtn.isHidden = true
//        PotionBtn.isHidden = true
//        PotionCount.isHidden = true
        
        viewT.itemListToggle(itemList: itemList, cancel: itemCancelBtn, potion: PotionBtn, lbl: PotionCount, toggle: true)
    }
    @IBAction func potionDidTouch(_ sender: Any) {
        
        // adds health
//        itemList.isHidden = false
//        itemCancelBtn.isHidden = false
//        PotionBtn.isHidden = false
//        PotionCount.isHidden = false
        viewT.itemListToggle(itemList: itemList, cancel: itemCancelBtn, potion: PotionBtn, lbl: PotionCount, toggle: false)
        
        viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, pkmnBtn:pkmnBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:true)
        
        firstMessageBtn.isEnabled = true
        if battle.playerPotionUsage() == -1 {
            viewT.itemListToggle(itemList: itemList, cancel: itemCancelBtn, potion: PotionBtn, lbl: PotionCount, toggle: true)
            sound.potion.play()
            viewT.potion(hp: myHPprogress, who: player)
            myScoreLbl.text = "\(player.score)"
//            battle.message1 = "TIMEOUT! \(player.name) used POTION"
        } else {
            viewT.itemListToggle(itemList: itemList, cancel: itemCancelBtn, potion: PotionBtn, lbl: PotionCount, toggle: true)
            battle.message1 = "Why are you trying to break my game?"
        }
        longBarLbl.text? = battle.message1
    }
    
//    func playerPotionUsage() -> Int {
//        var check = -2
//        // if items are available
//        if passed_playerItems != 0 {
//            // if progress is reasonable
//            if player.progress != 1.0 {
//            let health = (1.1/player.startHP) * 3
//            let test = player.progress + health
//            if test > 1 {
//                player.progress = 1
//                player.score = Int(player.startHP)
//            } else {
//            player.progress = player.progress + health
//            player.score = player.score + 3
//            }
//            sound.potion.play()
//            myHPprogress.setProgress(Float(player.progress), animated: true)
//            passed_playerItems -= 1
//            PotionCount.text = "x\(passed_playerItems)"
//            // MARK: depends on max ie. should not go over the original HP.
//
//            myScoreLbl.text = "\(player.score)"
//            print(passed_playerItems)
//            
//            check = -1
//            }
//        }
//        itemList.isHidden = true
//        itemCancelBtn.isHidden = true
//        PotionBtn.isHidden = true
//        PotionCount.isHidden = true
//        return check
//        
//    }
    
    
    @IBAction func fightBtnTouch(_ sender: Any) {
        sound.play_click()
//        menuBarVisible(hidden: true)
        viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, pkmnBtn:pkmnBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:true)
//        longBarText.isEnabled = false
//        longBarLbl.text = ""
        viewT.fightBtnTouch(longBarText: longBarText, longBarLbl: longBarLbl, string: "", enable: false)
        
//        fightBarVisible(hidden: false)
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
            viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, pkmnBtn:pkmnBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:false)

        }
        sound.play_click()
        
//        if longBarLbl.text == "Got away safely!" {
//            dismiss(animated: true, completion: nil)
//        
//        } else if (longBarLbl.text?.contains("KNOCKED"))! || (longBarLbl.text?.contains("DEFEATED"))! || (longBarLbl.text?.contains("DRAW!"))! {
//            sound.play_click()
//            longBarLbl.text = "TAP TO BATTLE AGAIN"
//        } else if (longBarLbl.text?.contains("TAP TO BATTLE AGAIN"))!{
//            sound.play_click()
//            dismiss(animated: true, completion: nil)
//        } else {
//            sound.play_click()
//            
//            longBarLbl.text? = ""
//            menuBarVisible(hidden: false)
//        }
    }
    
    @IBOutlet weak var muteButton: UIButton!
    
    @IBOutlet weak var unmuteButton: UIButton!
    
    @IBAction func toggleMute(_ sender: Any) {
        sound.toggle_mute()
        muteButton.isHidden = true
        unmuteButton.isHidden = false
        
    }
    @IBAction func toggleUnmute(_ sender: Any) {
        sound.toggle_unmute()
        muteButton.isHidden = false
        unmuteButton.isHidden = true
        
    }
    
    let random = RandomGenerator()

    @IBAction func afterFirstMessage(_ sender: Any) {
        sound.play_click()
        
        let next_msg = battle.afterFirstMessage()
        viewT.setBattleImage2(pMoveImage: myMoveImage, oMoveImage: oppMoveImage, pImage: myImage, oImage: oakImage, word: next_msg, name: player.name)
        if battle.message1.contains("POTION"){
            oak_itemCount.isHidden = true
        }
        firstMessageBtn.isEnabled = false
        secondMessageBtn.isEnabled = true
        longBarLbl.text? = next_msg
        
//        if message1 != "" {
//            
//            if message1.contains("BOTH used"){
//                // MARK: randomiser here?
//                random.range = 4
//                let result = random.output+1
//                if result == 2 || result == 4 {
//                message2 = "They hurt themselves in their confusion!"
//                } else {
//                    message2 = "The moves had no effect!"
//                }
//            } else if message1.contains("POTION"){
//                message2 = "Round skipped!"
//                oak_itemCount.isHidden = true
//            } else if message1.contains("game?"){
//                message2 = "Why?"
//            }
//            
//            switch message1 {
//            case "OAK used X-SCISSOR! It's not very effective...":
//                message2 = "\(passed_name) used ROCK SMASH! It's super effective!"
//                myImage.isHidden = true
//                myMoveImage.image = UIImage(named: "rock")
//                break
//            case "OAK used ROCK SMASH! It's not very effective...":
//                message2 = "\(passed_name) used PAPER CUT! It's super effective!"
//                myImage.isHidden = true
//                myMoveImage.image = UIImage(named: "paper")
//                break
//            case "OAK used PAPER CUT! It's not very effective...":
//                message2 = "\(passed_name) used X-SCISSOR! It's super effective!"
//                myImage.isHidden = true
//                myMoveImage.image = UIImage(named: "scissors-1")
//                break
//            case "\(passed_name) used ROCK SMASH! It's not very effective...":
//                message2 = "OAK used PAPER CUT! It's super effective!"
//                oakImage.isHidden = true
//                oppMoveImage.image = UIImage(named: "paper")
//                break
//            case "\(passed_name) used PAPER CUT! It's not very effective...":
//                message2 = "OAK used X-SCISSOR! It's super effective!"
//                oakImage.isHidden = true
//                oppMoveImage.image = UIImage(named: "scissors-1")
//                break
//            case "\(passed_name) used X-SCISSOR! It's not very effective...":
//                message2 = "OAK used ROCK SMASH! It's super effective!"
//                oakImage.isHidden = true
//                oppMoveImage.image = UIImage(named: "rock")
//                break
// 
//                default:
//                break
//            }
//            firstMessageBtn.isEnabled = false
//            secondMessageBtn.isEnabled = true
//            longBarLbl.text? = message2
//        }
    }
    
    @IBAction func afterSecondMessage(_ sender: Any) {
        sound.play_click()
        
        let string = battle.afterSecondMessage()
        viewT.checkWhoLost(string: string, hp1: myHPprogress, hp2: myOppProgress, who1: player, who2: oak)

        myScoreLbl.text = "\(player.score)"
        // resets the battle scene i.e oak and ash visible
        viewT.reset(longBarLbl: longBarLbl, btn: secondMessageBtn, pMoveImage: myMoveImage, oMoveImage: oppMoveImage, pImage: myImage, oImage: oakImage)
        
        viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, pkmnBtn:pkmnBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:false)

        let number = battle.endGame()
        let check = viewT.endGame(check: number, name: player, longBarText: longBarText, longBarLbl: longBarLbl)
        
        if check == 1 {
            viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, pkmnBtn:pkmnBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:true)
            sound.song.stop()
            sound.loss.play()
        } else if check == 2{
            viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, pkmnBtn:pkmnBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:true)
            sound.song.stop()
            sound.victory.play()
        } else if check == 3{
            viewT.menuBarSet(menuBar:menuBar, fightBtn:fightBtn, itemBtn:itemBtn, pkmnBtn:pkmnBtn, runBtn:runItem, arrow2Btn:arrowBtn, hidden:true)
            sound.song.stop()
            sound.victory.play()
        }
        
//        MARK: if name is ASH, then ASH exists in message2 within SMASH -> modify this message2 search
//         if i also called myself oak then these searches would mess up
//        if message2.contains("\(passed_name)"){
////            oak.score -= 1
//            oakBarMethod()
//        } else if message2.contains("OAK"){
//            player.score -= 1
//            playerBarMethod()
//        } else {
//            if message2.contains("confusion"){
////                oak.score -= 1
//                oakBarMethod()
//                player.score -= 1
//                playerBarMethod()
//            }
//        }
//        myScoreLbl.text = "\(player.score)"
//        
//        longBarLbl.text? = ""
//        menuBarVisible(hidden: false)
//        message1 = ""
//        message2 = ""
//        secondMessageBtn.isEnabled = false
//        myMoveImage.image = nil
//        oppMoveImage.image = nil
//        myImage.isHidden = false
//        oakImage.isHidden = false
//    
//        // MARK: this needs changing as no longer want to battle again
//            if player.progress <= 0 || oak.progress <= 0 {
//                if player.score <= 0 {
//                    longBarText.isEnabled = true
//                    sound.song.stop()
//                    sound.loss.play()
//                    player.score = 0
//                    menuBarVisible(hidden: true)
//                    longBarLbl.text? = "OAK WINS! \(player.name) WAS KNOCKED OUT!"
//                } else {
//                    longBarText.isEnabled = true
//                    sound.song.stop()
//                    sound.victory.play()
//                    oak.score = 0
//                    menuBarVisible(hidden: true)
//                    longBarLbl.text? = "\(player.name) WINS! PROFESSOR OAK was DEFEATED!"
//                }
//            } else if player.progress <= 0 && oak.progress <= 0 {
//                longBarText.isEnabled = true
//                sound.song.stop()
//                sound.victory.play()
//                oak.score = 0
//                menuBarVisible(hidden: true)
//                longBarLbl.text? = "DRAW!"
//            }
        
    }
    
    var viewT = View()
//    func fightBarVisible(hidden:Bool){
////        viewT.fightBar(fightBar: fightBar, fightBtn: fightBtn, arrow2Btn: arrow2btn, fightStack: fightStack, hidden: hidden)
//        fightBar.isHidden = hidden
//        fightBtn.isHidden = hidden
//        arrow2btn.isHidden = hidden
//        fightStack.isHidden = hidden
//    }
//    
//    func menuBarVisible(hidden:Bool){
//        menuBar.isHidden = hidden
//        fightBtn.isHidden = hidden
//        itemBtn.isHidden = hidden
//        pkmnBtn.isHidden = hidden
//        runItem.isHidden = hidden
//        arrowBtn.isHidden = hidden
//        
//    }
    
//    func playerBarMethod(){
//        let damage = 1.1 / player.startHP
//        player.progress = player.progress - damage
//        myHPprogress.setProgress(Float(player.progress), animated: true)
//    }
//    
//    func oakBarMethod(){
//        let damage = 1.1 / oak.startHP
//        oak.progress = oak.progress - damage
//        myOppProgress.setProgress(Float(oak.progress), animated: true)
//    }
    
    // FIGHT BUTTON TOUCHED
    @IBAction func myMoveMethod(sender:UIButton){
        sound.play_click()
        
        myMoveNumber = sender.tag
        
        // gets the battle sentence & correct images
        let outcome = battle.player_move(number: myMoveNumber)
        if battle.message1.contains("HOLD ON! OAK used POTION") {
            sound.potion.play()
            myOppProgress.setProgress(Float(oak.progress), animated: true)
            
            oak_itemCount.isHidden = false
            oak_itemCount.text = ("POTION x\(oak.item_bag)")
        }
        viewT.setBattleImage1(pMoveImage: myMoveImage, oMoveImage: oppMoveImage, pImage: myImage, oImage: oakImage, word: outcome, name: player.name)
        
        firstMessageBtn.isEnabled = true
        longBarLbl.text? = outcome
        
        viewT.fightBar(fightBar: fightBar, fightBtn: fightBtn, arrow2Btn: arrow2btn, fightStack: fightStack, hidden: true)
        
//        if myMoveNumber == Weapon.Rock.rawValue {
//            
//            // randomise opponentmove
//            // process the battle, hide fight menu
//            processBattle(me: myMoveNumber, opp: opponentMoveMethod())
//            fightBarVisible(hidden: true)
//            
//        } else if myMoveNumber == Weapon.Paper.rawValue {
//            
//            
//            // process the battle, hide fight menu
//            processBattle(me: myMoveNumber, opp: opponentMoveMethod())
//            fightBarVisible(hidden: true)
//            
//        } else if myMoveNumber == Weapon.Scissors.rawValue {
//            
//            // process the battle, hide fight menu
//            processBattle(me: myMoveNumber, opp: opponentMoveMethod())
//            fightBarVisible(hidden: true)
//        }
        
        
    }
    
//    var message1 = ""
//    var message2 = ""
    
//    func processBattle(me: Int,opp: Int) {
//        
//        if opp == -1 {
//            
//            firstMessageBtn.isEnabled = true
//            self.message1 = "HOLD ON! OAK used POTION"
//            longBarLbl.text? = message1
//            
//        } else {
//        
//            if me == Weapon.Rock.rawValue && opp == Weapon.Rock.rawValue {
//                
//                firstMessageBtn.isEnabled = true
//                self.message1 = "BOTH used ROCK SMASH!"
//                longBarLbl.text? = message1
//                myMoveImage.image = UIImage(named: "rock")
//                oppMoveImage.image = UIImage(named: "rock")
//                
//                myImage.isHidden = true
//                oakImage.isHidden = true
//                
//            } else if me == Weapon.Rock.rawValue && opp == Weapon.Scissors.rawValue {
//                
//                firstMessageBtn.isEnabled = true
//                self.message1 = "OAK used X-SCISSOR! It's not very effective..."
//                longBarLbl.text? = message1
//                oppMoveImage.image = UIImage(named: "scissors-1")
//                
//                oakImage.isHidden = true
//                
//            } else if me == Weapon.Rock.rawValue && opp == Weapon.Paper.rawValue {
//                
//                firstMessageBtn.isEnabled = true
//                self.message1 = "\(passed_name) used ROCK SMASH! It's not very effective..."
//                longBarLbl.text? = message1
//                myImage.isHidden = true
//                myMoveImage.image = UIImage(named: "rock")
//                
//            } else if me == Weapon.Paper.rawValue && opp == Weapon.Paper.rawValue {
//                
//                firstMessageBtn.isEnabled = true
//                self.message1 = "BOTH used PAPER CUT!"
//                longBarLbl.text? = message1
//                myMoveImage.image = UIImage(named: "paper")
//                oppMoveImage.image = UIImage(named: "paper")
//                
//                myImage.isHidden = true
//                oakImage.isHidden = true
//                
//            } else if me == Weapon.Paper.rawValue && opp == Weapon.Scissors.rawValue {
//                
//                firstMessageBtn.isEnabled = true
//                self.message1 = "\(passed_name) used PAPER CUT! It's not very effective..."
//                longBarLbl.text? = message1
//                myImage.isHidden = true
//                myMoveImage.image = UIImage(named: "paper")
//                
//                
//            } else if me == Weapon.Paper.rawValue && opp == Weapon.Rock.rawValue {
//                
//                firstMessageBtn.isEnabled = true
//                self.message1 = "OAK used ROCK SMASH! It's not very effective..."
//                longBarLbl.text? = message1
//                
//                oakImage.isHidden = true
//                oppMoveImage.image = UIImage(named: "rock")
//                
//                
//            } else if me == Weapon.Scissors.rawValue && opp == Weapon.Scissors.rawValue {
//                
//                firstMessageBtn.isEnabled = true
//                self.message1 = "BOTH used X-SCISSOR!"
//                longBarLbl.text? = message1
//                myMoveImage.image = UIImage(named: "scissors-1")
//                oppMoveImage.image = UIImage(named: "scissors-1")
//                
//                myImage.isHidden = true
//                oakImage.isHidden = true
//                
//            } else if me == Weapon.Scissors.rawValue && opp == Weapon.Paper.rawValue {
//                
//                firstMessageBtn.isEnabled = true
//                self.message1 = "OAK used PAPER CUT! It's not very effective..."
//                longBarLbl.text? = message1
//                
//                oakImage.isHidden = true
//                oppMoveImage.image = UIImage(named: "paper")
//                
//            } else if me == Weapon.Scissors.rawValue && opp == Weapon.Rock.rawValue {
//                
//                firstMessageBtn.isEnabled = true
//                
//                self.message1 = "\(passed_name) used X-SCISSOR! It's not very effective..."
//                longBarLbl.text? = message1
//                myImage.isHidden = true
//                myMoveImage.image = UIImage(named: "scissors-1")
//                
//            }
//        }
//        
//    }
    
    func oakPotionUsage() -> Int {
        
        var check = -2
        if passed_oakItems != 0 {
            let health = (1.1/oak.startHP) * 3
            oak.progress = oak.progress + health
            sound.potion.play()
            self.myOppProgress.setProgress(Float(oak.progress), animated: true)
            passed_oakItems -= 1
            print("oak item count: \(passed_oakItems)")
            oak_itemCount.isHidden = false
            oak_itemCount.text = ("POTION x\(passed_oakItems)")
            check = -1
            
            print("\(oak.playerHP) + \(oak.progress) + \(oak.score)")
        }
        
        return check
    }
    
    // to find the opponent rock paper or scissors move
//    func opponentMoveMethod() -> Int {
//        random.range = 4
//        randomNumber = random.output
//        
//        if randomNumber == 3 {
//            if oak.progress <= 0.6 && passed_oakItems != 0{
//            opponentNumber = oakPotionUsage()
//            } else {
//                random.range = 3
//                randomNumber = random.output
//                print("roll again")
//            }
//        }
//        
//            if randomNumber == Weapon.Rock.rawValue {
//                
//                opponentMove = "\(Weapon.Rock)"
//                opponentNumber = randomNumber
//                //opponentMoveLbl.text? = opponentMove
//                
//            } else if randomNumber == Weapon.Paper.rawValue {
//                
//                opponentMove = "\(Weapon.Paper)"
//                opponentNumber = randomNumber
//                //opponentMoveLbl.text? = opponentMove
//                
//            } else if randomNumber == Weapon.Scissors.rawValue {
//                
//                opponentMove = "\(Weapon.Scissors)"
//                opponentNumber = randomNumber
//                //opponentMoveLbl.text? = opponentMove
//                
//            }
//        
//        return opponentNumber
//    }
    var battle:Battle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NEED TO CHANGE
        let set_player = Player(name:passed_name, start:passed_playerHP, hp:passed_playerHP, score:Int(passed_playerHP), items:passed_playerItems)
        player = set_player
        let set_oak = Player(name:"Oak", start:passed_oakHP, hp:passed_oakHP, score:Int(passed_oakHP), items:passed_oakItems)
        oak = set_oak
        
        battle = Battle(player: player, opponent: oak)
        
        // set the player and oak values
//        player.startHP = passed_playerHP
//        player.playerHP = passed_playerHP
//        player.score = Int(passed_playerHP)
//        
//        oak.startHP = passed_oakHP
//        oak.playerHP = passed_oakHP
//        oak.score = Int(passed_oakHP)
//        
//        player.name = passed_name
        playerName.text? = player.name
        
        myScoreLbl.text = "\(player.score)"
        originalScoreLbl.text = "\(player.score)"
        
        // no image
        myMoveImage.image = nil
        oppMoveImage.image = nil
        
        self.myHPprogress.transform = myHPprogress.transform.scaledBy(x: 1, y: 4)
        self.myHPprogress.setProgress(Float(player.playerHP), animated: true)
        
        self.myOppProgress.transform = myOppProgress.transform.scaledBy(x: 1, y: 4)
        self.myOppProgress.setProgress(Float(oak.playerHP), animated: true)
        
        
        longBarLbl.text = "PROFESSOR OAK wants to fight!"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sound.sound_setup()
        sound.song.play()
    }

}

