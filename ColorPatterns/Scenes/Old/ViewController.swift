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
    private var sounds = GameSounds()
    private var colors = GameEngine()
    private var user = Score()
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateSoundLabel),
                                               name: UIApplication.didBecomeActiveNotification, object: nil)
        
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
