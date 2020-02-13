//
//  StartMenuCreator.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Foundation

struct StartMenuCreator {

    func getController() -> StartMenuController {

        let viewModel = StartMenuViewModel()
        let controller = StartMenuController(viewModel: viewModel)

        viewModel.controller = controller

        return controller
    }
}
