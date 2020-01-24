//
//  GameViewModel.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

protocol GameViewModelDelegate: class {
    func didUpdateScore(score: Int)
}

final class GameViewModel {

    // TODO: Make a protocol for this class and then this class implementing that protocol, so you can use it in controller
    private var gameEngine: GameEngine
    private var gameStarted = false

    private(set) var userScore: Score

    weak var delegate: GameViewModelDelegate?

    init(gameEngine: GameEngine, score: Score) {
        self.gameEngine = gameEngine
        self.userScore = score
    }
}

extension GameViewModel {

    func shuffleColors() -> [CGFloat] {
        let colors = gameEngine.shuffleColors()
        print("colorsArray: \(colors)")
        return colors
    }
    
    func didPressColorBar(colorBar: Int) {
        gameEngine.pickedColor = gameEngine.colorsArray[colorBar]
        calculateScore()
        gameStarted = true
        helpPrints()
    }
}

private extension GameViewModel {

    private func calculateScore() {
        if gameStarted {
            userScore.updateScorePoints(gameEngine.colorRange.contains(gameEngine.pickedColor))
            delegate?.didUpdateScore(score: userScore.score)
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
