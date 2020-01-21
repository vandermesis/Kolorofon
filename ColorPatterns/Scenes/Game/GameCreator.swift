//
//  GameCreator.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Foundation

struct GameCreator {

    func getController() -> GameController {

        let gameEngine = GameEngine()
        let score = Score()
        let gameTimer = GameTimer()
        let gameSounds = GameSounds()
        let userDefaults = UserDefaults.standard
        let viewModel = GameViewModel(gameEngine: gameEngine,
                                      score: score)
        let controller = GameController(viewModel: viewModel,
                                        timer: gameTimer,
                                        sounds: gameSounds,
                                        userDefaults: userDefaults)
        return controller
    }
}
