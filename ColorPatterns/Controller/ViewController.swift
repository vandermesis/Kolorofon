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
    var audioPlayer : AVAudioPlayer!
    var audioOn = true
    let defaults = UserDefaults.standard
    var soundsArray = ["note1", "note2", "note3", "note4", "note5"]
    var pickedColor : CGFloat = 0
    var colorsArray = [CGFloat](repeating: 0.0, count: 5)
    var userScore = 0
    var pickedColorDataBase = [CGFloat]()
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
        if let userSettings = defaults.value(forKeyPath: "Sound") {
            audioOn = userSettings as! Bool
        }
        soundLabelToogle()
        yourScore.isHidden = true
        restartButton.isHidden = true
        updateColorPatterns()
        gameTimer()
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = 13
        timeLabel.layer.masksToBounds = true
        timeLabel.layer.cornerRadius = 13
        print("colorsArray:",colorsArray)
        print("audioOn: \(audioOn)")
    }
    
    //MARK: - User actions and score calculations
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        if audioOn == true {
            playSound(selectedFile: soundsArray[sender.tag-1])
        }
        pickedColor = colorsArray[sender.tag-1]
        pickedColorDataBase.append(pickedColor)
        let rangeOfPickedColor = pickedColorDataBase[0]-0.05...pickedColorDataBase[0]+0.05
        print("rangeOfPickedColor:",rangeOfPickedColor)
        if pickedColorDataBase.count > 1 {
                pickedColorDataBase.remove(at: 1)
        }
        print("pickedColorDataBase",pickedColorDataBase)
        updateColorPatterns()
        userScore = rangeOfPickedColor.contains(pickedColor) ? userScore+1 : userScore-1
        if userScore < 0 {
            userScore = 0
        }
        scoreLabel.text = String(userScore)
        print("colorsArray:",colorsArray)
        print("userScore:",userScore)
        }
    
    //FIXME: Swipe Action for updateCollorPatterns when user's color is not on screen
    @IBAction func swipeAction(_ sender: UISwipeGestureRecognizer) {
        updateColorPatterns()
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
        gameTimer()
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
        audioOn.toggle()
        defaults.set(audioOn, forKey: "Sound")
        soundLabelToogle()
    }
    
    func soundLabelToogle() {
        if audioOn == true {
            soundButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
            soundButton.setTitle("Sound On", for: .normal)
        }
        if audioOn == false {
            soundButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            soundButton.setTitle("Sound Off", for: .normal)
        }
    }
}
