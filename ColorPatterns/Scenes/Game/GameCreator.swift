//
//  GameCreator.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Foundation

struct GameCreator {

    func getController(difficulty: Level) -> GameController {

        let gameEngine = GameEngine(level: difficulty)
        let score = Score()
        let gameTimer = GameTimer()
        let gameSounds = GameSounds()
        let userDefaults = UserDefaults.standard
        let viewModel = GameViewModelImpl(gameEngine: gameEngine,
                                          gameTimer: gameTimer,
                                          score: score)
        let controller = GameController(viewModel: viewModel,
                                        sounds: gameSounds,
                                        userDefaults: userDefaults)

        viewModel.controller = controller
        gameTimer.delegate = viewModel

        return controller
    }
}
