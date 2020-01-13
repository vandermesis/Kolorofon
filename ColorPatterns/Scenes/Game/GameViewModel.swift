//
//  GameViewModel.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

final class GameViewModel {

    private var colorBarsEngine: GameColorBarsEngine
    private var userScore: Score
    private var gameStarted = false

    init(colorBarsEngine: GameColorBarsEngine, score: Score) {
        self.colorBarsEngine = colorBarsEngine
        self.userScore = score
    }
}

extension GameViewModel {

    func shuffleColors() -> [CGFloat] {
        let colors = colorBarsEngine.shuffleColors()
        print("colorsArray: \(colors)")
        return colors
    }
    
    func didPressColorBar(colorBar: Int) {
        colorBarsEngine.pickedColor = colorBarsEngine.array[colorBar]
        calculateScore()
        gameStarted = true
        helpPrints()
    }
}

private extension GameViewModel {

    private func calculateScore() {
        if gameStarted {
            userScore.addScorePoints(colorBarsEngine.range.contains(colorBarsEngine.pickedColor))
        } else {
            colorBarsEngine.userColor = colorBarsEngine.pickedColor
        }
    }

    //TODO: Remove prints when not needed
    private func helpPrints() {
        print("////////////////////////////////////////////")
        print("userColor: \(colorBarsEngine.userColor)")
        print("pickedColor: \(colorBarsEngine.pickedColor)")
        print("rangeOfPickedColor: \(colorBarsEngine.range)")
        print("pickedColor=DB:\(colorBarsEngine.range.contains(colorBarsEngine.pickedColor))")
        print("userScore: \(userScore.score)")
        print("gameStarted: \(gameStarted)")
    }
}
