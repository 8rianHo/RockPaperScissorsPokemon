//
//  Battle.swift
//  RockPaperScissors
//
//  Created by Brian Ho on 14/06/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import Foundation

class Battle {
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

        
        return outcome
        
    }
    
    func opponent_move() -> Int {
        random.range = 4
        var random_number = random.output

        var opponent_number = 0
        
        if random_number == 3 {
            if oak.progress <= 0.6 && oak.item_bag != 0{
                opponent_number = oakPotionUsage()
            } else {
                random.range = 3
                random_number = random.output
                
            }
        }
        
        if random_number == Weapon.Rock.rawValue {
            
            opponent_number = random_number
            
        } else if random_number == Weapon.Paper.rawValue {

            opponent_number = random_number
            
        } else if random_number == Weapon.Scissors.rawValue {
            
            opponent_number = random_number
            
        }
        
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
            
            message1 = "HOLD ON! OAK used POTION"
            
        } else {
            
            if player == Weapon.Rock.rawValue && opp == Weapon.Rock.rawValue {
                
                message1 = "BOTH used ROCK SMASH!"
                
            } else if player == Weapon.Rock.rawValue && opp == Weapon.Scissors.rawValue {
                
                message1 = "OAK used X-SCISSOR! It's not very effective..."

            } else if player == Weapon.Rock.rawValue && opp == Weapon.Paper.rawValue {
                
                message1 = "\(player1.name) used ROCK SMASH! It's not very effective..."
                
            } else if player == Weapon.Paper.rawValue && opp == Weapon.Paper.rawValue {
                
                message1 = "BOTH used PAPER CUT!"
                
            } else if player == Weapon.Paper.rawValue && opp == Weapon.Scissors.rawValue {
                
                message1 = "\(player1.name) used PAPER CUT! It's not very effective..."
                
            } else if player == Weapon.Paper.rawValue && opp == Weapon.Rock.rawValue {
                
                message1 = "OAK used ROCK SMASH! It's not very effective..."
                
                
            } else if player == Weapon.Scissors.rawValue && opp == Weapon.Scissors.rawValue {
                
                message1 = "BOTH used X-SCISSOR!"
                
            } else if player == Weapon.Scissors.rawValue && opp == Weapon.Paper.rawValue {
                
                message1 = "OAK used PAPER CUT! It's not very effective..."
                
            } else if player == Weapon.Scissors.rawValue && opp == Weapon.Rock.rawValue {
                
                message1 = "\(player1.name) used X-SCISSOR! It's not very effective..."
                
            }
        }
        return message1
    }
    
    func oakPotionUsage() -> Int {
        
        var check = -2
        if oak.item_bag != 0 {
            let health = (1.1/oak.startHP) * 3
            oak.progress = oak.progress + health
            oak.item_bag -= 1
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
                message1 = "TIMEOUT! \(player1.name) used POTION"
                check = -1
            }
        }
        return check
        
    }
    
    func afterFirstMessage() -> String {
        if message1 != "" {
            
            if message1.contains("BOTH used"){
                random.range = 4
                let result = random.output+1
                if result == 2 || result == 4 {
                    message2 = "They hurt themselves in their confusion!"
                } else {
                    message2 = "The moves had no effect!"
                }
            } else if message1.contains("POTION"){
                message2 = "Round skipped!"

            } else if message1.contains("game?"){
                message2 = "Why?"
            }
            
            switch message1 {
            case "OAK used X-SCISSOR! It's not very effective...":
                message2 = "\(player1.name) used ROCK SMASH! It's super effective!"
                
                break
            case "OAK used ROCK SMASH! It's not very effective...":
                message2 = "\(player1.name) used PAPER CUT! It's super effective!"

                break
            case "OAK used PAPER CUT! It's not very effective...":
                message2 = "\(player1.name) used X-SCISSOR! It's super effective!"

                break
            case "\(player1.name) used ROCK SMASH! It's not very effective...":
                message2 = "OAK used PAPER CUT! It's super effective!"

                break
            case "\(player1.name) used PAPER CUT! It's not very effective...":
                message2 = "OAK used X-SCISSOR! It's super effective!"

                break
            case "\(player1.name) used X-SCISSOR! It's not very effective...":
                message2 = "OAK used ROCK SMASH! It's super effective!"
                break
                
            default:
                break
            }
        }
        return message2

    }
    
    func afterSecondMessage() -> String{
        var who = ""
        if message2.contains("\(player1.name)"){
            who = "OAK"
        } else if message2.contains("OAK"){
            player1.score -= 1
            who = "\(player1.name)"
        } else if message2.contains("confusion"){
                who = "confusion"
                player1.score -= 1
            
        }
        return who
    }
    func endGame() -> Int{
        var num = 0
        if player1.progress <= 0 || oak.progress <= 0 {
            if player1.score <= 0 {
                num = 1
            } else {
                num = 2
            }
        } else if player1.progress <= 0 && oak.progress <= 0 {
            num = 3
        }
        return num

    }
    
}
