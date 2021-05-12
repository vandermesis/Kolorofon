//
//  GameTimer.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Foundation

protocol GameTimerDelegate: AnyObject {
    func timerDidEndCounting()
    func timerDidUpdate(seconds: Int)
}

protocol GameTimer {
    func start()
    func pause()
}

final class GameTimerImpl: GameTimer {

    private var gameTimer: Timer?

    weak var delegate: GameTimerDelegate?

    var timeLeft: Int = Constants.GameTimer.gameTime

    func start() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(onTimerFires),
                                         userInfo: nil,
                                         repeats: true)
    }

    func pause() {
        gameTimer?.invalidate()
        gameTimer = nil
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
