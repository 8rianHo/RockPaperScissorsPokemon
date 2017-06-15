//
//  Item.swift
//  RockPaperScissors
//
//  Created by Brian Ho on 12/06/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import Foundation

class Item {
    
    let random = RandomGenerator()
    private var _item_bag:Int = 0
    var item_bag: Int {
        get {
            return _item_bag
        }
        set {
            _item_bag = newValue
        }
    }
    // types of items
    private var potion: Int = 3
    private var _maxItems: Int = 5
    
    var maxItems: Int {
        get{
            return _maxItems
        }
    }
    // array of items randomised before each battle - for each player
    
    func start_items() -> Int {
        random.range = maxItems + 1
        item_bag = random.output
        
        return item_bag
    }
    
}
