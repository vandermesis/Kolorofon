//
//  GameOverCreator.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Foundation

struct GameOverCreator {

    func getController(score: Score) -> GameOverController {

        let viewModel = GameOverViewModel(userScore: score)
        let controller = GameOverController(viewModel: viewModel)

        return controller
    }
}
