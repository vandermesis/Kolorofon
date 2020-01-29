//
//  GameOverCreator.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

struct GameOverCreator {

    func getController(score: Score, gameController: UIViewController) -> GameOverController {

        let viewModel = GameOverViewModel(userScore: score)
        let gameOverController = GameOverController(viewModel: viewModel)

        gameOverController.gameController = gameController

        return gameOverController
    }
}
