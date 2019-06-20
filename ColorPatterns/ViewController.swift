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
    
    var audioPlayer : AVAudioPlayer!
    var soundsArray = ["note1", "note2", "note3", "note4", "note5"]
    var pickedColor : CGFloat = 0
    var colorsArray = [CGFloat]()
    var userScore = 0
    var pickedColorDataBase = [CGFloat]()
    var timer:Timer?
    var timeLeft = 60

    override func viewDidLoad() {
        
        updateColorPatterns()
        gameTimer()
        yourScore.isHidden = true
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBOutlet weak var colorBar1: UIButton!
    @IBOutlet weak var colorBar2: UIButton!
    @IBOutlet weak var colorBar3: UIButton!
    @IBOutlet weak var colorBar4: UIButton!
    @IBOutlet weak var colorBar5: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var yourScore: UILabel!
    
    
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        
        
        playSound(selectedFile: soundsArray[sender.tag-1])
        pickedColor = colorsArray[sender.tag-1]
        pickedColorDataBase.append(pickedColor)
        if pickedColorDataBase.count > 1 {
                pickedColorDataBase.remove(at: 1)
        }
        
        print(pickedColorDataBase)
        updateColorPatterns()
        if pickedColor == pickedColorDataBase[0] {
            userScore += 1
            scoreLabel.text = String(userScore)
        }
        if pickedColor != pickedColorDataBase[0] {
            userScore -= 1
            scoreLabel.text = String(userScore)
        }
        print(colorsArray)
        print(userScore)
        
        
        }
   
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Why are you shaking me?")
            updateColorPatterns()
            print(colorsArray)
        }
    }
    
    func playSound(selectedFile : String){
        
        let soundURL = Bundle.main.url(forResource: selectedFile, withExtension: "wav")
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL!)
        } catch {
            print(error.localizedDescription)
        }
        audioPlayer.play()
        
    }
    @IBAction func swipeAction(_ sender: UISwipeGestureRecognizer) {
        
        updateColorPatterns()
        print(colorsArray)
    
    }
    
    
    
    
    func updateColorPatterns() {
    
        let color1 = CGFloat.random(in: 0.0 ... 0.99)
        let color2 = CGFloat.random(in: 0.0 ... 0.99)
        let color3 = CGFloat.random(in: 0.0 ... 0.99)
        let color4 = CGFloat.random(in: 0.0 ... 0.99)
        let color5 = CGFloat.random(in: 0.0 ... 0.99)
        
        let color1ToCGFloat = CGFloat((String(format: "%.1f", color1) as NSString).doubleValue)
        let color2ToCGFloat = CGFloat((String(format: "%.1f", color2) as NSString).doubleValue)
        let color3ToCGFloat = CGFloat((String(format: "%.1f", color3) as NSString).doubleValue)
        let color4ToCGFloat = CGFloat((String(format: "%.1f", color4) as NSString).doubleValue)
        let color5ToCGFloat = CGFloat((String(format: "%.1f", color5) as NSString).doubleValue)
        
    
        colorBar1.backgroundColor = UIColor(hue: color1ToCGFloat, saturation: 1, brightness: 1, alpha: 1)
        colorBar2.backgroundColor = UIColor(hue: color2ToCGFloat, saturation: 1, brightness: 1, alpha: 1)
        colorBar3.backgroundColor = UIColor(hue: color3ToCGFloat, saturation: 1, brightness: 1, alpha: 1)
        colorBar4.backgroundColor = UIColor(hue: color4ToCGFloat, saturation: 1, brightness: 1, alpha: 1)
        colorBar5.backgroundColor = UIColor(hue: color5ToCGFloat, saturation: 1, brightness: 1, alpha: 1)
        
        colorsArray = [color1ToCGFloat, color2ToCGFloat, color3ToCGFloat, color4ToCGFloat, color5ToCGFloat]
    }
    
    func gameTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        timeLabel.text = String(timeLeft)
        print(timeLeft)
        
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            yourScore.isHidden = false
            colorBar1.isHidden = true
            colorBar2.isHidden = true
            colorBar3.isHidden = true
            colorBar4.isHidden = true
            colorBar5.isHidden = true
            scoreLabel.isHidden = true
            timeLabel.isHidden = true
            yourScore.text = "Your score is \(userScore)"
        }
    }
    
}
