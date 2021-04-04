//
//  TutorialCreator.swift
//  Kolorofon
//
//  Created by Marek Skrzelowski on 04/04/2021.
//  Copyright © 2021 vandermesis. All rights reserved.
//

import Foundation

struct TutorialCreator {

    func getController(mode: Mode) -> TutorialController {

        let userDefaults = UserDefaults.standard
        let viewModel = TutorialViewModelImpl(mode: mode, userDefaults: userDefaults)
        let controller = TutorialController(viewModel: viewModel)

        viewModel.controller = controller

        return controller
    }
}
