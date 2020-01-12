//
//  ViewController.swift
//  ColorPatterns
//
//  Created by Administrator on 29.04.2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Constants and Variables declared
    private let defaults = UserDefaults.standard
    private var sounds = Sounds()
    private var colors = Colors()
    private var user = User()
    private var gameTimer = GameTimer()
    private var gameStarted = false
    
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var yourScore: UILabel!
    @IBOutlet private weak var restartButton: UIButton!
    @IBOutlet private weak var soundButton: UIButton!
    @IBOutlet private var colorBars: [UIButton]!
    
    // MARK: - Methods called after startup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Nofify when app didBecomeActive to update sound label if needed
        NotificationCenter.default.addObserver(self, selector: #selector(updateSoundLabel), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        gameTimer.delegate = self
        addSwipe()
        uiGameMode()
    }
    
    // MARK: - User press color patern button actions and score calculations
    @IBAction private func colorPressed(_ sender: UIButton) {
        colors.pickedColor = colors.array[sender.tag-1]
        if defaults.bool(forKey: "Sound") == true {
            sounds.play(selectedFile: sounds.array[sender.tag-1])
        }
        if gameStarted {
            user.calculateScore(colors.range.contains(colors.pickedColor))
            print("rangeOfPickedColor:", colors.range)
        } else {
            colors.userColor = colors.pickedColor
        }
        scoreLabel.text = String(user.score)
        gameStarted = true
        shuffleColors()
        
        //  Prints ;) - develping helpers
        print("////////////////////////////////////////////")
        print("userColor:\(colors.userColor)")
        print("pickedColor: \(colors.pickedColor)")
        print("colorsArray:", colors.array)
        print("userScore:", user.score)
        print("gameStarted:", gameStarted)
        print("pickedColor=DB:", colors.pickedColor == colors.userColor)
        }
    
    //  Swipe Action for updateCollorPatterns when user's color is not on screen
    private func addSwipe() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        shuffleColors()
        print("swipe action")
        print("colorsArray:", colors.array)
    }
    
    //  Shake action for shuffleColors when user's color is not on screen
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            shuffleColors()
            print("colorsArray:", colors.array)
        }
    }
    
    // MARK: - Shuffle color patterns
    private func shuffleColors() {
        let updatedColors = colors.shuffle()
        for i in 0...4 {
            colorBars[i].backgroundColor = UIColor(hue: updatedColors[i], saturation: 1, brightness: 1, alpha: 1)
        }
    }
    
    // MARK: - Restart game method
    @IBAction private func restartButtonPressed(_ sender: Any) {
        uiGameMode()
    }
    
    // MARK: - Update UI methods
    private func uiGameMode() {
        
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
        colors.userColor = 0
        scoreLabel.text = String(user.score)
        timeLabel.text = String(gameTimer.timeLeft)
        updateSoundLabel()
        shuffleColors()
        gameTimer.start()
        print("colorsArray:", colors.array)
    }
    
    private func uiScoreMode() {
        yourScore.text = "Your score is \(user.score)"
        yourScore.isHidden = false
        restartButton.isHidden = false
        for i in 0...4 {
            colorBars[i].isHidden = true
        }
        scoreLabel.isHidden = true
        timeLabel.isHidden = true
    }
    
    // MARK: - Sound on/off using UserDefaults
    @IBAction private func soundButtonPressed(_ sender: UIButton) {
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
