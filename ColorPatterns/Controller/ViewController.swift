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
    var soundsArray = ["note1", "note2", "note3", "note4", "note5"]
    var colorsArray = [CGFloat](repeating: 0.0, count: 5)
    var pickedColor : CGFloat = 0
    var pickedColorDataBase = [CGFloat]()
    var userScore = 0
    var timer:Timer?
    var timeLeft = 60
    
    @IBOutlet weak var colorBar1: UIButton!
    @IBOutlet weak var colorBar2: UIButton!
    @IBOutlet weak var colorBar3: UIButton!
    @IBOutlet weak var colorBar4: UIButton!
    @IBOutlet weak var colorBar5: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var yourScore: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    
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
        
        //  Set label's background to round corners
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = 13
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 13
    }
    
    //MARK: - User press color patern button actions and score calculations
    //FIXME:    User gets one point when picking his colour
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        
        //  Play sound as set in settings by user
        if defaults.bool(forKey: "Sound") == true {
            playSound(selectedFile: soundsArray[sender.tag-1])
        }
        
        //  Persist color picked by user
        pickedColor = colorsArray[sender.tag-1]
        pickedColorDataBase.append(pickedColor)
        if pickedColorDataBase.count > 1 {
            pickedColorDataBase.remove(at: 1)
        }
        
        //  Calculate user score if user hit color in range(+ 0.05 -0.05) of his picked color
        let rangeOfPickedColor = pickedColorDataBase[0]-0.05...pickedColorDataBase[0]+0.05
        userScore = rangeOfPickedColor.contains(pickedColor) ? userScore+1 : userScore-1
        if userScore < 0 {
            userScore = 0
        }
        
        //  Update score label
        scoreLabel.text = String(userScore)
        
        if pickedColor == pickedColorDataBase[0] {
            gameTimer()
        }
        
        //  Shuffle colors on app start
        updateColorPatterns()
        
        //  Prints ;) - develping helpers
        print("////////////////////////////////////////////")
        print("pickedColorDataBase: \(pickedColorDataBase)")
        print("rangeOfPickedColor:",rangeOfPickedColor)
        print("pickedColor: \(pickedColor)")
        print("colorsArray:",colorsArray)
        print("userScore:",userScore)
        }
    
    //  Swipe Action for updateCollorPatterns when user's color is not on screen
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        updateColorPatterns()
        print("swipe action")
        print("colorsArray:",colorsArray)
    }
    
    //  Shake action for updateColorPatterns when user's color is not on screen
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            updateColorPatterns()
            print("colorsArray:",colorsArray)
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
        colorsArray = colorsArray.map {_ in CGFloat((String(format: "%.2f", CGFloat.random(in: 0.0...0.9)) as NSString).doubleValue)}
        colorBar1.backgroundColor = UIColor(hue: colorsArray[0], saturation: 1, brightness: 1, alpha: 1)
        colorBar2.backgroundColor = UIColor(hue: colorsArray[1], saturation: 1, brightness: 1, alpha: 1)
        colorBar3.backgroundColor = UIColor(hue: colorsArray[2], saturation: 1, brightness: 1, alpha: 1)
        colorBar4.backgroundColor = UIColor(hue: colorsArray[3], saturation: 1, brightness: 1, alpha: 1)
        colorBar5.backgroundColor = UIColor(hue: colorsArray[4], saturation: 1, brightness: 1, alpha: 1)
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
        userScore = 0
        timeLeft = 60
        scoreLabel.text = "00"
        timeLabel.text = "60"
        pickedColorDataBase = [CGFloat]()
        uiGameMode()
    }
    
    //MARK: - Update UI methods
    func uiGameMode() {
        yourScore.isHidden = true
        restartButton.isHidden = true
        colorBar1.isHidden = false
        colorBar2.isHidden = false
        colorBar3.isHidden = false
        colorBar4.isHidden = false
        colorBar5.isHidden = false
        scoreLabel.isHidden = false
        timeLabel.isHidden = false
        updateColorPatterns()
        print("colorsArray:",colorsArray)
    }
    
    func uiScoreMode() {
        yourScore.text = "Your score is \(userScore)"
        yourScore.isHidden = false
        restartButton.isHidden = false
        colorBar1.isHidden = true
        colorBar2.isHidden = true
        colorBar3.isHidden = true
        colorBar4.isHidden = true
        colorBar5.isHidden = true
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
