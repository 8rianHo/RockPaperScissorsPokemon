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
    
    // fight bar
    @IBOutlet weak var fightBar: UIImageView!
    @IBOutlet weak var arrow2btn: UIImageView!
    @IBOutlet weak var rockBtn: UIButton!
    @IBOutlet weak var paperBtn: UIButton!
    @IBOutlet weak var scissorsBtn: UIButton!
    @IBOutlet weak var fightStack: UIStackView!
    
    @IBOutlet weak var myScoreLbl: UILabel!
    
    var myMove = ""
    var myMoveNumber = 0
    var opponentMove = ""
    var opponentNumber = 0
    var randomNumber = 0
    
    var myScore = 5
    var oppScore = 5
    
    enum Weapon: Int {
        case Rock = 0
        case Paper = 1
        case Scissors = 2
    }
    
    @IBAction func runBtnTouch(_ sender: Any) {
        
        longBarLbl.text = "PROFESSOR OAK wants to fight!"
        longBarText.isEnabled = true
        myScore = 5
        oppScore = 5
        myScoreLbl.text = "5"
        myHealth = 1.0
        oppHealth = 1.0
        myHPprogress.setProgress(Float(myHealth), animated: true)
        myOppProgress.setProgress(Float(oppHealth), animated: true)
        menuBarVisible(hidden: true)
        song.stop()
        
    }
    
    
    @IBAction func fightBtnTouch(_ sender: Any) {
        playSound()
        menuBarVisible(hidden: true)
        longBarText.isEnabled = false
        longBarLbl.text = ""
        
        fightBarVisible(hidden: false)
    }
    
    @IBAction func messageLblTouch(_ sender: Any) {
        
        if myScore <= 0 || oppScore <= 0{
            victory.stop()
            song.play()
            print("restarting")
            longBarLbl.text = "PROFESSOR OAK wants to fight!"
            longBarText.isEnabled = true
            myScore = 5
            oppScore = 5
            myScoreLbl.text = "5"
            myHealth = 1.0
            oppHealth = 1.0
            myHPprogress.setProgress(Float(myHealth), animated: true)
            myOppProgress.setProgress(Float(oppHealth), animated: true)
            menuBarVisible(hidden: true)
            
        } else {
            playSound()
            longBarLbl.text? = ""
            menuBarVisible(hidden: false)
        }
    }

    @IBAction func afterFirstMessage(_ sender: Any) {
        playSound()
        if message1 != "" {
            
            if message1.contains("BOTH used"){
                message2 = "They hurt themselves in their confusion!"
            }
            
            switch message1 {
            case "OAK used X-SCISSOR! It's not very effective...":
                message2 = "BRIAN used ROCK SMASH! It's super effective!"
                myImage.isHidden = true
                myMoveImage.image = UIImage(named: "rock")
                break
            case "OAK used ROCK SMASH! It's not very effective...":
                message2 = "BRIAN used PAPER CUT! It's super effective!"
                myImage.isHidden = true
                myMoveImage.image = UIImage(named: "paper")
                break
            case "OAK used PAPER CUT! It's not very effective...":
                message2 = "BRIAN used X-SCISSOR! It's super effective!"
                myImage.isHidden = true
                myMoveImage.image = UIImage(named: "scissors-1")
                break
            case "BRIAN used ROCK SMASH! It's not very effective...":
                message2 = "OAK used PAPER CUT! It's super effective!"
                oakImage.isHidden = true
                oppMoveImage.image = UIImage(named: "paper")
                break
            case "BRIAN used PAPER CUT! It's not very effective...":
                message2 = "OAK used X-SCISSOR! It's super effective!"
                oakImage.isHidden = true
                oppMoveImage.image = UIImage(named: "scissors-1")
                break
            case "BRIAN used X-SCISSOR! It's not very effective...":
                message2 = "OAK used ROCK SMASH! It's super effective!"
                oakImage.isHidden = true
                oppMoveImage.image = UIImage(named: "rock")
                break

                default:
                break
            }
            firstMessageBtn.isEnabled = false
            secondMessageBtn.isEnabled = true
            longBarLbl.text? = message2
        }
    }
    
    @IBAction func afterSecondMessage(_ sender: Any) {
        playSound()
        
        if message2.contains("BRIAN"){
            oppScore -= 1
            myOppbarMethod()
        } else if message2.contains("OAK"){
            myScore -= 1
            myHPbarMethod()
        } else {
            oppScore -= 1
            myOppbarMethod()
            myScore -= 1
            myHPbarMethod()
        }
        myScoreLbl.text = "\(myScore)"
        
        longBarLbl.text? = ""
        menuBarVisible(hidden: false)
        message1 = ""
        message2 = ""
        secondMessageBtn.isEnabled = false
        myMoveImage.image = nil
        oppMoveImage.image = nil
        myImage.isHidden = false
        oakImage.isHidden = false
    
        if myScore <= 0 || oppScore <= 0 {
            if myScore <= 0 {
                longBarText.isEnabled = true
                song.stop()
                myScore = 0
                menuBarVisible(hidden: true)
                longBarLbl.text? = "FUCK OAK! BRIAN wants to battle AGAIN!"
            } else {
                longBarText.isEnabled = true
                song.stop()
                victory.play()
                oppScore = 0
                menuBarVisible(hidden: true)
                longBarLbl.text? = "PROFESSOR OAK was DEFEATED! FUCK THE PROF."
            }
        }
    }
        
    
    func fightBarVisible(hidden:Bool){
        fightBar.isHidden = hidden
        fightBtn.isHidden = hidden
        arrow2btn.isHidden = hidden
        fightStack.isHidden = hidden
    }
    
    func menuBarVisible(hidden:Bool){
        menuBar.isHidden = hidden
        fightBtn.isHidden = hidden
        itemBtn.isHidden = hidden
        pkmnBtn.isHidden = hidden
        runItem.isHidden = hidden
        arrowBtn.isHidden = hidden
        
    }
    
    func battleMessage(firstMove:String, secondMove:String)->String{
        let message = "PIKACHU used \(firstMove)"
        
        return message
    }
    
    func myHPbarMethod(){
        let damage = 0.22
        myHealth = myHealth - damage
        myHPprogress.setProgress(Float(myHealth), animated: true)
    }
    
    func myOppbarMethod(){
        let damage = 0.22
        oppHealth = oppHealth - damage
        myOppProgress.setProgress(Float(oppHealth), animated: true)
    }
    
    @IBAction func myMoveMethod(sender:UIButton){
        playSound()
        
        myMove = sender.currentTitle!
        myMoveNumber = sender.tag
        
        if myMoveNumber == Weapon.Rock.rawValue {
            
            // randomise opponentmove
            // process the battle, hide fight menu
            processBattle(me: myMoveNumber, opp: opponentMoveMethod())
            fightBarVisible(hidden: true)
            
        } else if myMoveNumber == Weapon.Paper.rawValue {
            
            
            // process the battle, hide fight menu
            processBattle(me: myMoveNumber, opp: opponentMoveMethod())
            fightBarVisible(hidden: true)
            
        } else if myMoveNumber == Weapon.Scissors.rawValue {
            
            // process the battle, hide fight menu
            processBattle(me: myMoveNumber, opp: opponentMoveMethod())
            fightBarVisible(hidden: true)
        }
        
        
    }
    var message1 = ""
    var message2 = ""
    
    func processBattle(me: Int,opp: Int) {
        
        if me == Weapon.Rock.rawValue && opp == Weapon.Rock.rawValue {
            
            firstMessageBtn.isEnabled = true
            self.message1 = "BOTH used ROCK SMASH!"
            longBarLbl.text? = message1
            myMoveImage.image = UIImage(named: "rock")
            oppMoveImage.image = UIImage(named: "rock")
            
            myImage.isHidden = true
            oakImage.isHidden = true
            
        } else if me == Weapon.Rock.rawValue && opp == Weapon.Scissors.rawValue {
            
            firstMessageBtn.isEnabled = true
            self.message1 = "OAK used X-SCISSOR! It's not very effective..."
            longBarLbl.text? = message1
            oppMoveImage.image = UIImage(named: "scissors-1")
            
            oakImage.isHidden = true
            
        } else if me == Weapon.Rock.rawValue && opp == Weapon.Paper.rawValue {
            
            firstMessageBtn.isEnabled = true
            self.message1 = "BRIAN used ROCK SMASH! It's not very effective..."
            longBarLbl.text? = message1
            myImage.isHidden = true
            myMoveImage.image = UIImage(named: "rock")
            
        } else if me == Weapon.Paper.rawValue && opp == Weapon.Paper.rawValue {
            
            firstMessageBtn.isEnabled = true
            self.message1 = "BOTH used PAPER CUT!"
            longBarLbl.text? = message1
            myMoveImage.image = UIImage(named: "paper")
            oppMoveImage.image = UIImage(named: "paper")
            
            myImage.isHidden = true
            oakImage.isHidden = true
            
        } else if me == Weapon.Paper.rawValue && opp == Weapon.Scissors.rawValue {
            
            firstMessageBtn.isEnabled = true
            self.message1 = "BRIAN used PAPER CUT! It's not very effective..."
            longBarLbl.text? = message1
            myImage.isHidden = true
            myMoveImage.image = UIImage(named: "paper")
            
            
        } else if me == Weapon.Paper.rawValue && opp == Weapon.Rock.rawValue {
            
            firstMessageBtn.isEnabled = true
            self.message1 = "OAK used ROCK SMASH! It's not very effective..."
            longBarLbl.text? = message1
            
            oakImage.isHidden = true
            oppMoveImage.image = UIImage(named: "rock")
            
            
        } else if me == Weapon.Scissors.rawValue && opp == Weapon.Scissors.rawValue {
            
            firstMessageBtn.isEnabled = true
            self.message1 = "BOTH used X-SCISSOR!"
            longBarLbl.text? = message1
            myMoveImage.image = UIImage(named: "scissors-1")
            oppMoveImage.image = UIImage(named: "scissors-1")
            
            myImage.isHidden = true
            oakImage.isHidden = true
            
        } else if me == Weapon.Scissors.rawValue && opp == Weapon.Paper.rawValue {
            
            firstMessageBtn.isEnabled = true
            self.message1 = "OAK used PAPER CUT! It's not very effective..."
            longBarLbl.text? = message1
            
            oakImage.isHidden = true
            oppMoveImage.image = UIImage(named: "paper")
            
        } else if me == Weapon.Scissors.rawValue && opp == Weapon.Rock.rawValue {
            
            firstMessageBtn.isEnabled = true
            
            self.message1 = "BRIAN used X-SCISSOR! It's not very effective..."
            longBarLbl.text? = message1
            myImage.isHidden = true
            myMoveImage.image = UIImage(named: "scissors-1")
            
        }
        
    }
    
    // to find the opponent rock paper or scissors move
    func opponentMoveMethod() -> Int {
        randomNumber = Int(arc4random_uniform(2+1))
        
        if randomNumber == Weapon.Rock.rawValue {
            
            opponentMove = "\(Weapon.Rock)"
            opponentNumber = randomNumber
            //opponentMoveLbl.text? = opponentMove
            
        } else if randomNumber == Weapon.Paper.rawValue {
            
            opponentMove = "\(Weapon.Paper)"
            opponentNumber = randomNumber
            //opponentMoveLbl.text? = opponentMove
            
        } else if randomNumber == Weapon.Scissors.rawValue {
            
            opponentMove = "\(Weapon.Scissors)"
            opponentNumber = randomNumber
            //opponentMoveLbl.text? = opponentMove
            
        }
        
        return opponentNumber
    }
    
    var myHealth = 1.0
    var oppHealth = 1.0
    var btnSound: AVAudioPlayer!
    var song: AVAudioPlayer!
    var victory: AVAudioPlayer!
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // no image
        myMoveImage.image = nil
        oppMoveImage.image = nil
        
        // adding sound file from project folder for resource named "btn" and of type .wav file.
        let path = Bundle.main.path(forResource: "click", ofType: "wav")
        // turns the path into a sound URL
        let soundURL = URL(fileURLWithPath: path!)
        let path1 = Bundle.main.path(forResource: "battlesound", ofType: "mp3")
        // turns the path into a sound URL
        let soundURL1 = URL(fileURLWithPath: path1!)
        let path2 = Bundle.main.path(forResource: "victory", ofType: "mp3")
        let soundURL2 = URL(fileURLWithPath: path2!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            try song = AVAudioPlayer(contentsOf: soundURL1)
            song.play()
            song.numberOfLoops = 2
            try victory = AVAudioPlayer(contentsOf: soundURL2)
            victory.prepareToPlay()

        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        myScoreLbl.text = "\(myScore)"
        
        self.myHPprogress.transform = myHPprogress.transform.scaledBy(x: 1, y: 4)
        self.myHPprogress.setProgress(Float(myHealth), animated: true)
        
        self.myOppProgress.transform = myOppProgress.transform.scaledBy(x: 1, y: 4)
        self.myOppProgress.setProgress(Float(myHealth), animated: true)
        
        longBarLbl.text = "PROFESSOR OAK wants to fight!"
    }



}

