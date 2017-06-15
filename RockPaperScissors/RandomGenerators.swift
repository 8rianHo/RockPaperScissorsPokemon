//
//  RandomGenerators.swift
//  RockPaperScissors
//
//  Created by Brian Ho on 12/05/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import Foundation

class RandomGenerator {
    private var _range: Int!
    private var _output: Int!
    
    var range: Int {
        get{
            return _range
        }
        set{
            let rangeOut = Int(arc4random_uniform(UInt32(newValue)))
            _output = rangeOut
            print(output)
        }
    }
    
    var output: Int{
        get{
            return _output
        }
        set{
            _output = newValue
        }
    }
}
