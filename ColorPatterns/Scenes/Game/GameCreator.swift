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

        let userDefaults = UserDefaults.standard
        let gameEngine = GameEngine(level: difficulty)
        let score = Score()
        let gameTimer = GameTimerImpl()
        let gameSounds = GameSounds(userDefaults: userDefaults)
        let viewModel = GameViewModelImpl(gameEngine: gameEngine,
                                          gameTimer: gameTimer,
                                          gameSounds: gameSounds,
                                          score: score)
        let controller = GameController(viewModel: viewModel)
        
        viewModel.controller = controller
        gameTimer.delegate = viewModel

        return controller
    }
}
