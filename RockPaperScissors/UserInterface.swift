//
//  UserInterface.swift
//  RockPaperScissors
//
//  Created by Brian Ho on 14/06/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import Foundation
import UIKit

class UserInterface{
    //Pokemon background
    var longBarText: UIButton!
    var longBarLbl: UILabel!
    var myHPbar: UIView!
    var opponentHPbar: UIView!
    var firstMessageBtn: UIButton!
    var secondMessageBtn: UIButton!
    
    var myHPprogress: UIProgressView!
    var myOppProgress: UIProgressView!
    
    // move images
    var myMoveImage: UIImageView!
    var oppMoveImage: UIImageView!
    var myImage: UIImageView!
    var oakImage: UIImageView!
    
    // medium bar
    var menuBar: UIImageView!
    var fightBtn: UIButton!
    var itemBtn: UIButton!
    var pkmnBtn: UIButton!
    var runItem: UIButton!
    var arrowBtn: UIImageView!
    
    // item bar
    var itemList: UIImageView!
    var itemCancelBtn: UIButton!
    var PotionBtn: UIButton!
    var PotionCount: UILabel!
    
    
    // fight bar
    var fightBar: UIImageView!
    var arrow2Btn: UIImageView!
    var rockBtn: UIButton!
    var paperBtn: UIButton!
    var scissorsBtn: UIButton!
    var fightStack: UIStackView!
    
    var myScoreLbl: UILabel!
    var originalScoreLbl: UILabel!
    
    // MARK: testing
    var playerName: UILabel!
    var passed_name:String = ""
    var passed_playerHP:Double = 0.0
    var passed_oakHP:Double = 0.0
    var passed_oakItems:Int = 0
    var passed_playerItems:Int = 0
    var oak_itemCount: UILabel!
    // fight menu
//    private var _fightBar: UIImageView!
//    private var _fightBtn: UIButton!
//    private var _arrow2btn: UIImageView!
//    private var _fightStack: UIStackView!
//    
//    var fightBar: UIImageView! {
//        get {return _fightBar}
//        set {_fightBar = newValue}
//    }
//    var fightBtn: UIButton! {
//        get {return _fightBtn}
//        set {_fightBtn = newValue}
//    }
//    var arrow2Btn: UIImageView! {
//        get {return _arrow2btn}
//        set {_arrow2btn = newValue}
//    }
//    var fightStack: UIStackView! {
//        get {return _fightStack}
//        set {_fightStack = newValue}
//    }
    
    //fightBar:UIImageView, fightBtn:UIButton, arrow2Btn:UIImageView, fightStack:UIStackView,
    func fightBarVisible(hidden:Bool){
        fightBar(fightBar: fightBar, fightBtn: fightBtn, arrow2Btn: arrow2Btn, fightStack: fightStack, hidden: hidden)
    }
    private func fightBar(fightBar:UIImageView, fightBtn:UIButton, arrow2Btn:UIImageView, fightStack:UIStackView, hidden:Bool){
        fightBar.isHidden = hidden
        fightBtn.isHidden = hidden
        arrow2Btn.isHidden = hidden
        fightStack.isHidden = hidden
    }
//    func battleString(name:String){
//        battleImages(playerImg: <#T##UIImageView#>, oakImg: <#T##UIImageView#>, name: <#T##String#>)
//    }
    func battleImages(playerImg:UIImageView, oakImg:UIImageView, name:String){
        playerImg.image = UIImage(named: name)
    }
    
}
