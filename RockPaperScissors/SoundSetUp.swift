//
//  SoundSetUp.swift
//  RockPaperScissors
//
//  Created by Brian Ho on 12/05/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import AVFoundation

class Sound {
    
    private var _btnSound: AVAudioPlayer!
    var btnSound: AVAudioPlayer!{
        get{
            return _btnSound
        }
        set{
            _btnSound = newValue
        }
    }
    private var _song: AVAudioPlayer!
    var song: AVAudioPlayer!{
        get{
            return _song
        }
        set{
            _song = newValue
        }
    }
    private var _victory: AVAudioPlayer!
    var victory: AVAudioPlayer!{
        get{
            return _victory
        }
        set{
            _victory = newValue
        }
    }
    private var _runaway: AVAudioPlayer!
    var runaway: AVAudioPlayer!{
        get{
            return _runaway
        }
        set{
            _runaway = newValue
        }
    }
    private var _potion: AVAudioPlayer!
    var potion: AVAudioPlayer!{
        get{
           return _potion
        }
        set{
            _potion = newValue
        }
    }
    private var _menu: AVAudioPlayer!
    var menu: AVAudioPlayer!{
        get{
            return _menu
        }
        set{
            _menu = newValue
        }
    }
    private var _loss: AVAudioPlayer!
    var loss: AVAudioPlayer!{
        get{
            return _loss
        }
        set{
            _loss = newValue
        }
    }
    
    func play_menu(){
        if !menu.isPlaying {
            menu.currentTime = 0
            menu.play()
        }
        
       menu.play()
    }
    
    func play_click(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func toggle_mute(){
        let volume = btnSound.volume
        if volume == 1.0 {
            volume_setup(volume: 0.0)
        }
        
    }
    func toggle_unmute(){
        let volume = btnSound.volume
        if volume == 0.0 {
            volume_setup(volume: 1.0)
        }
        
    }
    
    func volume_setup(volume:Float){
        btnSound.volume = volume
        song.volume = volume
        victory.volume = volume
        potion.volume = volume
        runaway.volume = volume
        loss.volume = volume
    }
    
    func sound_setup(){
        let path = Bundle.main.path(forResource: "click", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        let path1 = Bundle.main.path(forResource: "battlesound", ofType: "m4a")
        let soundURL1 = URL(fileURLWithPath: path1!)
        let path2 = Bundle.main.path(forResource: "victory", ofType: "mp3")
        let soundURL2 = URL(fileURLWithPath: path2!)
        let path3 = Bundle.main.path(forResource: "runaway", ofType: "m4a")
        let soundURL3 = URL(fileURLWithPath: path3!)
        let path4 = Bundle.main.path(forResource: "potion", ofType: "m4a")
        let soundURL4 = URL(fileURLWithPath: path4!)
        let path5 = Bundle.main.path(forResource: "menu", ofType: "mp3")
        let soundURL5 = URL(fileURLWithPath: path5!)
        let path6 = Bundle.main.path(forResource: "loss", ofType: "mp3")
        let soundURL6 = URL(fileURLWithPath: path6!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            try song = AVAudioPlayer(contentsOf: soundURL1)
            song.prepareToPlay()
            song.numberOfLoops = 2
            try victory = AVAudioPlayer(contentsOf: soundURL2)
            victory.prepareToPlay()
            try runaway = AVAudioPlayer(contentsOf: soundURL3)
            runaway.prepareToPlay()
            try potion = AVAudioPlayer(contentsOf: soundURL4)
            potion.prepareToPlay()
            try menu = AVAudioPlayer(contentsOf: soundURL5)
            menu.prepareToPlay()
            try loss = AVAudioPlayer(contentsOf: soundURL6)
            loss.prepareToPlay()

            
        } catch _ as NSError {
            //print(error.debugDescription)
        }
    }
    
}
