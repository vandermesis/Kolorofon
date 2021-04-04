//
//  GameViewModel.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

enum Mode: Int {
    case game = 0
    case tutorial = 1
}

protocol GameViewModel {
    var mode: Mode { get set }
    var isFirstGamePlayed: Bool { get }

    func startTimer()
    func pauseTimer()
    func shuffleColors() -> [UIColor]
    func didPressColorBar(colorBar: Int)
    func didSwipeDown()
}

final class GameViewModelImpl {

    private let userDefaults: UserDefaults

    weak var controller: GameController?

    var mode: Mode

    var isFirstGamePlayed: Bool {
        return userDefaults.bool(forKey: Constants.UserDefaultsKeys.firstGamePlayed)
    }

    private var gameStarted = false
    private var gameEngine: GameEngine
    private var gameTimer: GameTimer
    private var gameSounds: GameSounds
    private(set) var userScore: Score

    init(mode: Mode,
         gameEngine: GameEngine,
         gameTimer: GameTimer,
         gameSounds: GameSounds,
         score: Score,
         defaults: UserDefaults) {
        self.mode = mode
        self.gameEngine = gameEngine
        self.gameTimer = gameTimer
        self.gameSounds = gameSounds
        self.userScore = score
        self.userDefaults = defaults
    }
}

extension GameViewModelImpl: GameViewModel {

    func startTimer() {
        gameTimer.start()
    }

    func pauseTimer() {
        gameTimer.pause()
    }

    func shuffleColors() -> [UIColor] {
        let colors = gameEngine.getRandomColors()
        return colors
    }
    
    func didPressColorBar(colorBar: Int) {
        gameSounds.play(soundFile: colorBar)
        gameEngine.pickedColor = gameEngine.randomColorsArray[colorBar]
        calculateScore()
        gameStarted = true
    }

    func didSwipeDown() {
        gameSounds.play(soundFile: 5)
    }
}

private extension GameViewModelImpl {

    private func calculateScore() {
        if gameStarted {
            userScore.updateScorePoints(gameEngine.pickedColor == gameEngine.userColor)
            controller?.updateScoreLabel(score: userScore.score)
            controller?.updateMultiplierLabel(multiplier: userScore.scoreMultiplier)
        } else {
            gameEngine.userColor = gameEngine.pickedColor
        }
    }
}

extension GameViewModelImpl: GameTimerDelegate {

    func timerDidEndCounting() {
        controller?.navigateToGameOver(userScore: userScore, level: gameEngine.level)
    }

    func timerDidUpdate(seconds: Int) {
        controller?.updateTimeLabel(seconds: seconds)
    }
}
