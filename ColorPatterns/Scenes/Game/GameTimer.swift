//
//  GameTimer.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Foundation

protocol GameTimerDelegate: class {
    func timerEnded()
    func timerUpdate()
}

final class GameTimer {

    private var timer: Timer?

    weak var delegate: GameTimerDelegate?

    var timeLeft = 60

    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
}

private extension GameTimer {

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
