//
//  GameViewModel.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

protocol GameViewModel {
    func startTimer()
    func shuffleColors() -> [CGFloat]
    func didPressColorBar(colorBar: Int)
    func didSwipeDown()
}

final class GameViewModelImpl {

    private var gameStarted = false
    private var gameEngine: GameEngine
    private var gameTimer: GameTimer
    private var gameSounds: GameSounds
    private(set) var userScore: Score

    weak var controller: GameController?

    init(gameEngine: GameEngine,
         gameTimer: GameTimer,
         gameSounds: GameSounds,
         score: Score) {
        self.gameEngine = gameEngine
        self.gameTimer = gameTimer
        self.gameSounds = gameSounds
        self.userScore = score
    }
}

extension GameViewModelImpl: GameViewModel {

    func startTimer() {
        gameTimer.start()
    }

    func shuffleColors() -> [CGFloat] {
        let colors = gameEngine.shuffleColors()
        print("colorsArray: \(colors)")
        return colors
    }
    
    func didPressColorBar(colorBar: Int) {
        gameSounds.play(soundFile: colorBar)
        gameEngine.pickedColor = gameEngine.colorsArray[colorBar]
        calculateScore()
        gameStarted = true
        helpPrints()
    }

    func didSwipeDown() {
        gameSounds.play(soundFile: 5)
    }
}

private extension GameViewModelImpl {

    private func calculateScore() {
        if gameStarted {
            userScore.updateScorePoints(gameEngine.colorRange.contains(gameEngine.pickedColor))
            controller?.updateScoreLabel(score: userScore.score)
        } else {
            gameEngine.userColor = gameEngine.pickedColor
        }
    }

    // TODO: Remove prints when not needed
    private func helpPrints() {
        print("////////////////////////////////////////////")
        print("userColor: \(gameEngine.userColor)")
        print("pickedColor: \(gameEngine.pickedColor)")
        print("rangeOfPickedColor: \(gameEngine.colorRange)")
        print("pickedColor=DB:\(gameEngine.colorRange.contains(gameEngine.pickedColor))")
        print("userScore: \(userScore.score)")
        print("gameStarted: \(gameStarted)")
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
