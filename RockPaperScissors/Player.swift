//
//  Player.swift
//  RockPaperScissors
//
//  Created by Brian Ho on 12/06/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import Foundation

class Player {
    
    private var start_HP: Double = 0.0
    var startHP: Double{
        get{
            return start_HP
        }
        set{
            start_HP = newValue
        }
    }

    private var player_HP: Double = 0.0
    var playerHP: Double {
        get{
            return player_HP
        }
        set{
            player_HP = newValue
        }
    }
    
    private var player_name: String = ""
    var name: String {
        get{
            return player_name
        }
        set{
            player_name = newValue
        }
    }
    
    private var score_label: Int = 0
    var score: Int {
        get{
            // score label should be related to playerHP
            return Int(player_HP)
        }
        set{
            score_label = newValue
            playerHP = Double(score_label)
        }
    }
    
    private var progress_bar: Double = 1.0
    var progress: Double {
        get{
            return progress_bar
        }
        set{
            progress_bar = newValue
            score_label = Int(progress_bar)
        }
    }
    let random = RandomGenerator()
    private var _item_bag:Int = 0
    private var _maxItems: Int = 5
    var maxItems: Int {
        get{
            return _maxItems
        }
    }
    var item_bag: Int {
        get {
            return _item_bag
        }
        set {
            _item_bag = newValue
        }
    }
    func start_items() -> Int {
        random.range = maxItems + 1
        item_bag = random.output
        
        return item_bag
    }
    
    // constructor
    init(name:String, start:Double, hp:Double, score:Int, items:Int){
        player_name = name
        start_HP = start
        player_HP = hp
        score_label = score
        item_bag = items
    }
    init(){
    }
    
}
