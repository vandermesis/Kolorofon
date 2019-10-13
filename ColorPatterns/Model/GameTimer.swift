//
//  GameTimer.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Foundation

protocol GameTimerDelegate {
    func timerEnded()
    func timerUpdate()
}

class GameTimer {

    private var timer: Timer?
    var delegate: GameTimerDelegate?
    var timeLeft = 60
    
    //MARK: - Timer methods
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    @objc private func onTimerFires() {
        
        timeLeft -= 1
        delegate?.timerUpdate()
        
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            delegate?.timerEnded()
            timeLeft = 60
        }
    }
}
