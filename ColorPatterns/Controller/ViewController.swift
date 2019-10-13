//
//  ViewController.swift
//  ColorPatterns
//
//  Created by Administrator on 29.04.2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Constants and Variables declared
    let defaults = UserDefaults.standard
    var sounds = Sounds()
    var colors = Colors()
    var user = User()
    var gameTimer = GameTimer()
    var gameStarted = false
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var yourScore: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet var colorBars: [UIButton]!
    
    //MARK: - Methods called after startup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add swipe down gesture to shuffle colors
        addSwipe()
        
        //  Nofify when app didBecomeActive to update sound label if needed
        NotificationCenter.default.addObserver(self, selector:#selector(updateSoundLabel), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        //  Prepare UI for new game
        uiGameMode()
        
        // GameTimer delegate
        gameTimer.delegate = self
    }
    
    private func addSwipe() {
        
        //  Configure swipe gesture to update color patterns if no user color is on the screen
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    //MARK: - User press color patern button actions and score calculations
    @IBAction func colorPressed(_ sender: UIButton) {
        
        //  Play sound as set in settings by user
        if defaults.bool(forKey: "Sound") == true {
            sounds.play(selectedFile: sounds.array[sender.tag-1])
        }
    
        colors.pickedColor = colors.array[sender.tag-1]
        
        if gameStarted {
            
            user.calculateScore(colors.range.contains(colors.pickedColor))
            print("rangeOfPickedColor:", colors.range)
            
        } else {
            
            //  Persist first color picked by user
            colors.userColor = colors.pickedColor
        }
        
        //  Update score label
        scoreLabel.text = String(user.score)
        
        //  Shuffle colors
        shuffleColors()
        
        // Set gameStarted
        gameStarted = true
        
        //  Prints ;) - develping helpers
        print("////////////////////////////////////////////")
        print("userColor:\(colors.userColor)")
        print("pickedColor: \(colors.pickedColor)")
        print("colorsArray:",colors.array)
        print("userScore:",user.score)
        print("gameStarted:",gameStarted)
        print("pickedColor=DB:",colors.pickedColor == colors.userColor)
        }
    
    //  Swipe Action for updateCollorPatterns when user's color is not on screen
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        shuffleColors()
        print("swipe action")
        print("colorsArray:",colors.array)
    }
    
    //  Shake action for shuffleColors when user's color is not on screen
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            shuffleColors()
            print("colorsArray:",colors.array)
        }
    }
    
    //MARK: - Update color patterns
    func shuffleColors() {
        let updatedColors = colors.shuffle()
        for i in 0...4 {
            colorBars[i].backgroundColor = UIColor(hue: updatedColors[i], saturation: 1, brightness: 1, alpha: 1)
        }
    }
    
    //MARK: - Restart game method
    @IBAction func restartButtonPressed(_ sender: Any) {
        uiGameMode()
    }
    
    //MARK: - Update UI methods
    func uiGameMode() {
        //  Set label's background to round corners
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = 13
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 13
        
        scoreLabel.isHidden = false
        timeLabel.isHidden = false
        yourScore.isHidden = true
        restartButton.isHidden = true
        for i in 0...4 {
            colorBars[i].isHidden = false
        }
        
        gameStarted = false
        user.score = 0
        scoreLabel.text = String(user.score)
        timeLabel.text = String(gameTimer.timeLeft)
        colors.userColor = 0
        updateSoundLabel()
        shuffleColors()
        gameTimer.start()
        print("colorsArray:",colors.array)
    }
    
    func uiScoreMode() {
        yourScore.text = "Your score is \(user.score)"
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
        if defaults.value(forKeyPath: "Sound") == nil {
            defaults.set(true, forKey: "Sound")
        }
        if defaults.bool(forKey: "Sound") == true {
            soundButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
            soundButton.setTitle("Sound On", for: .normal)
        } else {
            soundButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            soundButton.setTitle("Sound Off", for: .normal)
        }
    }
}

extension ViewController: GameTimerDelegate {
    
    func timerUpdate() {
        timeLabel.text = String(gameTimer.timeLeft)
    }
    
    func timerEnded() {
        uiScoreMode()
    }
}
