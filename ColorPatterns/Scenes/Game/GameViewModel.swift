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

    init(colorBarsEngine: GameColorBarsEngine) {
        self.colorBarsEngine = colorBarsEngine
    }
}

extension GameViewModel {

    func shuffleColors() -> [CGFloat] {
        return colorBarsEngine.shuffleColors()
    }

    func didPressColorBar(colorBar: Int) {
        colorBarsEngine.pickedColor = colorBarsEngine.array[colorBar]

        //TODO: Remove when not needed
        print("////////////////////////////////////////////")
        print("userColor: \(colorBarsEngine.userColor)")
        print("pickedColor: \(colorBarsEngine.pickedColor)")
        print("colorsArray: \(colorBarsEngine.array)")
//        print("userScore: \(user.score)")
//        print("gameStarted: \(gameStarted)")
        print("pickedColor=DB:\(colorBarsEngine.pickedColor == colorBarsEngine.userColor)")
    }
}
