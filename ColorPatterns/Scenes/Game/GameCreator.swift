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

        let colorBarsEngine = GameColorBarsEngine()
        let viewModel = GameViewModel(colorBarsEngine: colorBarsEngine)
        let controller = GameController(viewModel: viewModel)

        return controller
    }
}
