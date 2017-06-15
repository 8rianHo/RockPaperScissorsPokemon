//
//  Battle.swift
//  RockPaperScissors
//
//  Created by Brian Ho on 14/06/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import Foundation
import UIKit

class Battle {
    var UI = UserInterface()
    var random = RandomGenerator()
    var sound = Sound()
    
    // Battle will take the 2 players and process accordingly
    var player1:Player!
    var oak:Player!
    init(player:Player!, opponent:Player!){
        player1 = player
        oak = opponent
    }
    
    enum Weapon: Int {
        case Rock = 0
        case Paper = 1
        case Scissors = 2
    }
    
    func player_move(number:Int) -> String{
        let move_number = number
        var outcome = ""
        // player choose rock, paper or scissors -> opponent chooses move -> process the battle
        if move_number == Weapon.Rock.rawValue {
            
            outcome = process_battle(player: move_number, opp: opponent_move())

            
        } else if move_number == Weapon.Paper.rawValue {
            
            outcome = process_battle(player: move_number, opp: opponent_move())

            
        } else if move_number == Weapon.Scissors.rawValue {
            
            outcome = process_battle(player: move_number, opp: opponent_move())

        }
//        fightBarVisible(hidden: true)
//        UI.fightBarVisible(hidden: true)
        print("me: \(move_number)")
        return outcome
        
    }
    
    func opponent_move() -> Int {
        random.range = 4
        var random_number = random.output
//        randomNumber = random.output
//        var opponent_move = ""
        var opponent_number = 0
        
        if random_number == 3 {
            if oak.progress <= 0.6 && oak.item_bag != 0{
                opponent_number = oakPotionUsage()
            } else {
                random.range = 3
                random_number = random.output
                print("roll again hi")
            }
        }
        
        if random_number == Weapon.Rock.rawValue {
            
//            opponent_move = "\(Weapon.Rock)"
            opponent_number = random_number
            //opponentMoveLbl.text? = opponentMove
            
        } else if random_number == Weapon.Paper.rawValue {
            
//            opponent_move = "\(Weapon.Paper)"
            opponent_number = random_number
            //opponentMoveLbl.text? = opponentMove
            
        } else if random_number == Weapon.Scissors.rawValue {
            
//            opponent_move = "\(Weapon.Scissors)"
            opponent_number = random_number
            //opponentMoveLbl.text? = opponentMove
            
        }
        print("opponent: \(opponent_number)")
        return opponent_number
    }
    
    // these need to change to Player()
    var message1 = ""
    var message2 = ""
    var passed_name = ""
    var passed_oakItems = 0
    var passed_playerItems = 0
    var outcome = ""
    
    func process_battle(player:Int, opp:Int) -> String{
        
        if opp == -1 {
            
//            UI.firstMessageBtn.isEnabled = true
//            self.message1 = "HOLD ON! OAK used POTION"
            message1 = "HOLD ON! OAK used POTION"
//            UI.longBarLbl.text? = message1
            
        } else {
            
            if player == Weapon.Rock.rawValue && opp == Weapon.Rock.rawValue {
                
//                UI.firstMessageBtn.isEnabled = true
//                self.message1 = "BOTH used ROCK SMASH!"
                message1 = "BOTH used ROCK SMASH!"
//                UI.longBarLbl.text? = message1
//                UI.myMoveImage.image = UIImage(named: "rock")
//                UI.oppMoveImage.image = UIImage(named: "rock")
//                
//                UI.myImage.isHidden = true
//                UI.oakImage.isHidden = true
                
            } else if player == Weapon.Rock.rawValue && opp == Weapon.Scissors.rawValue {
                
//                UI.firstMessageBtn.isEnabled = true
//                self.message1 = "OAK used X-SCISSOR! It's not very effective..."
                message1 = "OAK used X-SCISSOR! It's not very effective..."
//                UI.longBarLbl.text? = message1
//                UI.oppMoveImage.image = UIImage(named: "scissors-1")
//                
//                UI.oakImage.isHidden = true
                
            } else if player == Weapon.Rock.rawValue && opp == Weapon.Paper.rawValue {
                
//                UI.firstMessageBtn.isEnabled = true
                message1 = "\(player1.name) used ROCK SMASH! It's not very effective..."
//                UI.longBarLbl.text? = message1
//                UI.myImage.isHidden = true
//                UI.myMoveImage.image = UIImage(named: "rock")
                
            } else if player == Weapon.Paper.rawValue && opp == Weapon.Paper.rawValue {
                
//                UI.firstMessageBtn.isEnabled = true
                message1 = "BOTH used PAPER CUT!"
//                UI.longBarLbl.text? = message1
//                UI.myMoveImage.image = UIImage(named: "paper")
//                UI.oppMoveImage.image = UIImage(named: "paper")
//                
//                UI.myImage.isHidden = true
//                UI.oakImage.isHidden = true
                
            } else if player == Weapon.Paper.rawValue && opp == Weapon.Scissors.rawValue {
                
//                UI.firstMessageBtn.isEnabled = true
                message1 = "\(player1.name) used PAPER CUT! It's not very effective..."
//                UI.longBarLbl.text? = message1
//                UI.myImage.isHidden = true
//                UI.myMoveImage.image = UIImage(named: "paper")
                
                
            } else if player == Weapon.Paper.rawValue && opp == Weapon.Rock.rawValue {
                
//                UI.firstMessageBtn.isEnabled = true
                message1 = "OAK used ROCK SMASH! It's not very effective..."
//                UI.longBarLbl.text? = message1
                
//                UI.oakImage.isHidden = true
//                UI.oppMoveImage.image = UIImage(named: "rock")
                
                
            } else if player == Weapon.Scissors.rawValue && opp == Weapon.Scissors.rawValue {
                
//                UI.firstMessageBtn.isEnabled = true
                message1 = "BOTH used X-SCISSOR!"
//                UI.longBarLbl.text? = message1
//                UI.myMoveImage.image = UIImage(named: "scissors-1")
//                UI.oppMoveImage.image = UIImage(named: "scissors-1")
//                
//                UI.myImage.isHidden = true
//                UI.oakImage.isHidden = true
                
            } else if player == Weapon.Scissors.rawValue && opp == Weapon.Paper.rawValue {
                
//                UI.firstMessageBtn.isEnabled = true
                message1 = "OAK used PAPER CUT! It's not very effective..."
//                UI.longBarLbl.text? = message1
                
//                UI.oakImage.isHidden = true
//                UI.oppMoveImage.image = UIImage(named: "paper")
                
            } else if player == Weapon.Scissors.rawValue && opp == Weapon.Rock.rawValue {
                
//                UI.firstMessageBtn.isEnabled = true
                
                message1 = "\(player1.name) used X-SCISSOR! It's not very effective..."
//                UI.longBarLbl.text? = message1
//                UI.myImage.isHidden = true
//                UI.myMoveImage.image = UIImage(named: "scissors-1")
                
            }
        }
//        UI.firstMessageBtn.isEnabled = true
//        UI.longBarLbl.text? = message1
        return message1
    }
    
    func oakPotionUsage() -> Int {
        
        var check = -2
        if oak.item_bag != 0 {
            let health = (1.1/oak.startHP) * 3
            oak.progress = oak.progress + health
//            sound.potion.play()
//            UI.myOppProgress.setProgress(Float(oak.progress), animated: true)
            oak.item_bag -= 1
//            UI.oak_itemCount.isHidden = false
//            UI.oak_itemCount.text = ("POTION x\(oak.item_bag)")
            check = -1
            
        }
        
        return check
    }
    // remember to check first message for item count
    func playerPotionUsage() -> Int {
        var check = -2
        // if items are available
        if player1.item_bag != 0 {
            // if progress is reasonable
            if player1.progress != 1.0 {
                let health = (1.1/player1.startHP) * 3
                let test = player1.progress + health
                if test > 1 {
                    player1.progress = 1
                    player1.score = Int(player1.startHP)
                } else {
                    player1.progress = player1.progress + health
                    player1.score = player1.score + 3
                }
//                sound.potion.play()
//                UI.myHPprogress.setProgress(Float(player1.progress), animated: true)
//                player1.item_bag -= 1
//                UI.PotionCount.text = "x\(passed_playerItems)"
                // MARK: depends on max ie. should not go over the original HP.
                
//                UI.myScoreLbl.text = "\(player1.score)"
//                print(passed_playerItems)
                message1 = "TIMEOUT! \(player1.name) used POTION"
                check = -1
            }
            // if max health
//            message1 = "Why are you trying to break my game?"
        }
//        UI.itemList.isHidden = true
//        UI.itemCancelBtn.isHidden = true
//        UI.PotionBtn.isHidden = true
//        UI.PotionCount.isHidden = true
        return check
        
    }
    
    func afterFirstMessage() -> String {
        if message1 != "" {
            
            if message1.contains("BOTH used"){
                // MARK: randomiser here?
                random.range = 4
                let result = random.output+1
                if result == 2 || result == 4 {
                    message2 = "They hurt themselves in their confusion!"
                } else {
                    message2 = "The moves had no effect!"
                }
            } else if message1.contains("POTION"){
                message2 = "Round skipped!"
//                UI.oak_itemCount.isHidden = true
            } else if message1.contains("game?"){
                message2 = "Why?"
            }
            
            switch message1 {
            case "OAK used X-SCISSOR! It's not very effective...":
                message2 = "\(player1.name) used ROCK SMASH! It's super effective!"
//                UI.myImage.isHidden = true
//                UI.myMoveImage.image = UIImage(named: "rock")
                break
            case "OAK used ROCK SMASH! It's not very effective...":
                message2 = "\(player1.name) used PAPER CUT! It's super effective!"
//                UI.myImage.isHidden = true
//                UI.myMoveImage.image = UIImage(named: "paper")
                break
            case "OAK used PAPER CUT! It's not very effective...":
                message2 = "\(player1.name) used X-SCISSOR! It's super effective!"
//                UI.myImage.isHidden = true
//                UI.myMoveImage.image = UIImage(named: "scissors-1")
                break
            case "\(player1.name) used ROCK SMASH! It's not very effective...":
                message2 = "OAK used PAPER CUT! It's super effective!"
//                UI.oakImage.isHidden = true
//                UI.oppMoveImage.image = UIImage(named: "paper")
                break
            case "\(player1.name) used PAPER CUT! It's not very effective...":
                message2 = "OAK used X-SCISSOR! It's super effective!"
//                UI.oakImage.isHidden = true
//                UI.oppMoveImage.image = UIImage(named: "scissors-1")
                break
            case "\(player1.name) used X-SCISSOR! It's not very effective...":
                message2 = "OAK used ROCK SMASH! It's super effective!"
//                UI.oakImage.isHidden = true
//                UI.oppMoveImage.image = UIImage(named: "rock")
                break
                
            default:
                break
            }
//            UI.firstMessageBtn.isEnabled = false
//            UI.secondMessageBtn.isEnabled = true
//            UI.longBarLbl.text? = message2
        }
        return message2

    }
    
    func afterSecondMessage() -> String{
        var who = ""
        if message2.contains("\(player1.name)"){
            //            oak.score -= 1
//            oakBarMethod()
            who = "OAK"
        } else if message2.contains("OAK"){
            player1.score -= 1
//            playerBarMethod()
            who = "\(player1.name)"
        } else if message2.contains("confusion"){
                //                oak.score -= 1
//                oakBarMethod()
                who = "confusion"
                player1.score -= 1
//                playerBarMethod()
            
        }
//        UI.myScoreLbl.text = "\(player1.score)"
//        
//        
//        UI.longBarLbl.text? = ""
//        //menuBarVisible(hidden: false)
//        message1 = ""
//        message2 = ""
//        UI.secondMessageBtn.isEnabled = false
//        UI.myMoveImage.image = nil
//        UI.oppMoveImage.image = nil
//        UI.myImage.isHidden = false
//        UI.oakImage.isHidden = false
        
//        // MARK: this needs changing as no longer want to battle again
//        if player1.progress <= 0 || oak.progress <= 0 {
//            if player1.score <= 0 {
//                UI.longBarText.isEnabled = true
//                sound.song.stop()
//                sound.loss.play()
//                player1.score = 0
//                //menuBarVisible(hidden: true)
//                UI.longBarLbl.text? = "OAK WINS! \(player1.name) WAS KNOCKED OUT!"
//            } else {
//                UI.longBarText.isEnabled = true
//                sound.song.stop()
//                sound.victory.play()
//                oak.score = 0
//                //menuBarVisible(hidden: true)
//                UI.longBarLbl.text? = "\(player1.name) WINS! PROFESSOR OAK was DEFEATED!"
//            }
//        } else if player1.progress <= 0 && oak.progress <= 0 {
//            UI.longBarText.isEnabled = true
//            sound.song.stop()
//            sound.victory.play()
//            oak.score = 0
//            //menuBarVisible(hidden: true)
//            UI.longBarLbl.text? = "DRAW!"
//        }
        return who
    }
    func endGame() -> Int{
        var num = 0
        // MARK: this needs changing as no longer want to battle again
        if player1.progress <= 0 || oak.progress <= 0 {
            if player1.score <= 0 {
//                UI.longBarText.isEnabled = true
//                sound.song.stop()
//                sound.loss.play()
//                player1.score = 0
//                //menuBarVisible(hidden: true)
//                UI.longBarLbl.text? = "OAK WINS! \(player1.name) WAS KNOCKED OUT!"
                num = 1
            } else {
//                UI.longBarText.isEnabled = true
//                sound.song.stop()
//                sound.victory.play()
//                oak.score = 0
//                //menuBarVisible(hidden: true)
//                UI.longBarLbl.text? = "\(player1.name) WINS! PROFESSOR OAK was DEFEATED!"
                num = 2
            }
        } else if player1.progress <= 0 && oak.progress <= 0 {
//            UI.longBarText.isEnabled = true
//            sound.song.stop()
//            sound.victory.play()
//            oak.score = 0
//            //menuBarVisible(hidden: true)
//            UI.longBarLbl.text? = "DRAW!"
            num = 3
        }
        return num

    }
    
}
