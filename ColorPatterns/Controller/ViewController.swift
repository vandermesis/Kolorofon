//
//  ViewController.swift
//  ColorPatterns
//
//  Created by Administrator on 29.04.2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    //MARK: - Variables declared
    let defaults = UserDefaults.standard
    var audioPlayer : AVAudioPlayer!
    var updateColors = UpdateColors()
    var soundsArray = ["note1", "note2", "note3", "note4", "note5"]
    var userScore = 0
    var buttonPressedCount = false
    var timer:Timer?
    var timeLeft = 60
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var yourScore: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet var colorBars: [UIButton]!
    
    //MARK: - Methods called after startup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Configure swipe gesture to update color patterns if no user color is on the screen
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
        
        //  Nofify when app didBecomeActive to update sound label if needed
        NotificationCenter.default.addObserver(self, selector:#selector(updateSoundLabel), name: UIApplication.didBecomeActiveNotification, object: nil)
        if defaults.value(forKeyPath: "Sound") == nil {
            defaults.set(true, forKey: "Sound")
        }
        updateSoundLabel()
        
        //  Prepare UI for new game
        uiGameMode()
        
        // Start game timer
        gameTimer()
        
        //  Set label's background to round corners
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = 13
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 13
    }
    
    //MARK: - User press color patern button actions and score calculations
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        
        //  Play sound as set in settings by user
        if defaults.bool(forKey: "Sound") == true {
            playSound(selectedFile: soundsArray[sender.tag-1])
        }
        
        //  Persist color picked by user
        updateColors.pickedColor = updateColors.colorsArray[sender.tag-1]
        updateColors.pickedColorDataBase.append(updateColors.pickedColor)
        
        
        //  Calculate user score if user hit color in range(+ 0.05 -0.05) of his picked color
        let rangeOfPickedColor = updateColors.pickedColorDataBase[0]-0.05...updateColors.pickedColorDataBase[0]+0.05
        buttonPressedCount = true
        if buttonPressedCount {
            userScore = rangeOfPickedColor.contains(updateColors.pickedColor) ? userScore+1 : userScore-1
        }
        if userScore < 0 {
            userScore = 0
        }
        
        //  Update score label
        scoreLabel.text = String(userScore)
        
        //  Shuffle colors on app start
        updateColorPatterns()
        
        //  Prints ;) - develping helpers
        print("////////////////////////////////////////////")
        print("pickedColorDataBase:\(updateColors.pickedColorDataBase)")
        print("rangeOfPickedColor:",rangeOfPickedColor)
        print("pickedColor: \(updateColors.pickedColor)")
        print("colorsArray:",updateColors.colorsArray)
        print("userScore:",userScore)
        print("buttonPressedCount:",buttonPressedCount)
        print("pickedColor=DB:",updateColors.pickedColor == updateColors.pickedColorDataBase[0])
        }
    
    //  Swipe Action for updateCollorPatterns when user's color is not on screen
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        updateColorPatterns()
        print("swipe action")
        print("colorsArray:",updateColors.colorsArray)
    }
    
    //  Shake action for updateColorPatterns when user's color is not on screen
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            updateColorPatterns()
            print("colorsArray:",updateColors.colorsArray)
        }
    }
    
    //MARK: - Play sound method
    func playSound(selectedFile : String){
        let soundURL = Bundle.main.url(forResource: selectedFile, withExtension: "wav")
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL!)
        } catch {
            print(error.localizedDescription)
        }
        audioPlayer.play()
    }
    
    //MARK: - Update color patterns
    func updateColorPatterns() {
        let updatedColors = updateColors.shuffle()
        for i in 0...4 {
            colorBars[i].backgroundColor = UIColor(hue: updatedColors[i], saturation: 1, brightness: 1, alpha: 1)
        }
    }
    
    //MARK: - Timer methods
    func gameTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        timeLabel.text = String(timeLeft)
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            uiScoreMode()
        }
    }
    
    //MARK: - Restart game method
    @IBAction func restartButtonPressed(_ sender: Any) {
        uiGameMode()
        gameTimer()
    }
    
    //MARK: - Update UI methods
    func uiGameMode() {
        yourScore.isHidden = true
        restartButton.isHidden = true
        for i in 0...4 {
            colorBars[i].isHidden = false
        }
        scoreLabel.isHidden = false
        timeLabel.isHidden = false
        buttonPressedCount = false
        userScore = 0
        timer = nil
        timeLeft = 60
        scoreLabel.text = "00"
        timeLabel.text = "60"
        updateColors.pickedColorDataBase = [CGFloat]()
        updateColorPatterns()
        print("colorsArray:",updateColors.colorsArray)
    }
    
    func uiScoreMode() {
        yourScore.text = "Your score is \(userScore)"
        yourScore.isHidden = false
        restartButton.isHidden = false
        for i in 0...4 {
            colorBars[i].isHidden = true
        }
        scoreLabel.isHidden = true
        timeLabel.isHidden = true
    }
    
    //MARK: - Sound on/off using UserDefaults
    @IBAction func soundButtonPressed(_ sender: UIButton) {
        defaults.bool(forKey: "Sound") ? defaults.set(false, forKey: "Sound") : defaults.set(true, forKey: "Sound")
        updateSoundLabel()
    }
    
    @objc func updateSoundLabel() {
        if defaults.bool(forKey: "Sound") == true {
            soundButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
            soundButton.setTitle("Sound On", for: .normal)
        }
        if defaults.bool(forKey: "Sound") == false {
            soundButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            soundButton.setTitle("Sound Off", for: .normal)
        }
    }
}
