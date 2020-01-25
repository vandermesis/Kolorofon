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

protocol GameTimer {
    func start()
}

final class GameTimerImpl: GameTimer {

    private var gameTimer: Timer?

    weak var delegate: GameTimerDelegate?

    var timeLeft: Int = Constants.GameTimer.gameTime

    func start() {
        timeLeft = Constants.GameTimer.gameTime
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(onTimerFires),
                                         userInfo: nil,
                                         repeats: true)
    }
}

private extension GameTimerImpl {

    @objc private func onTimerFires() {
        timeLeft -= 1
        delegate?.timerDidUpdate(seconds: timeLeft)
        if timeLeft <= 0 {
            gameTimer?.invalidate()
            gameTimer = nil
            delegate?.timerDidEndCounting()
        }
    }
}
