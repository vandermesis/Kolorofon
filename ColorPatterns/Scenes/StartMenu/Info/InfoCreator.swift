//
//  InfoCreator.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/02/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Foundation

struct InfoCreator {

    func getController() -> InfoController {

        let viewModel = InfoViewModel()
        let controller = InfoController(viewModel: viewModel)

        viewModel.controller = controller

        return controller
    }
}
