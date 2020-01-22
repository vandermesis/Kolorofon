//
//  GameTimer.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Foundation

protocol GameTimerDelegate: class {
    func timerDidEndCounting()
    func timerDidUpdate(seconds: Int)
}

final class GameTimer {

    private var gameTimer: Timer?

    weak var delegate: GameTimerDelegate?

    var timeLeft = 60

    func start() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(onTimerFires),
                                         userInfo: nil,
                                         repeats: true)
    }
}

private extension GameTimer {

    @objc private func onTimerFires() {
        timeLeft -= 1
        delegate?.timerDidUpdate(seconds: timeLeft)
        if timeLeft <= 0 {
            gameTimer?.invalidate()
            gameTimer = nil
            delegate?.timerDidEndCounting()
            timeLeft = 60
        }
    }
}