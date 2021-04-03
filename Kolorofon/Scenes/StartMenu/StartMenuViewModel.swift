//
//  StartMenuViewModel.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Foundation
import GameKit

final class StartMenuViewModel {

    var difficulty: Level = .easy
    var userIsAuthenticated = false

    weak var controller: StartMenuController?

    func chooseDifficulty(level: Level) {
        difficulty = level
    }

    func checkGameCenterStatus() {
        if !userIsAuthenticated {
            authenticatePlayer()
        }
    }
}

private extension StartMenuViewModel {

    private func authenticatePlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = { viewController, _ -> Void in
            if let viewController = viewController {
                self.controller?.present(viewController, animated: true, completion: nil)
            } else if localPlayer.isAuthenticated {
                self.userIsAuthenticated = true
            }
        }
    }
}
