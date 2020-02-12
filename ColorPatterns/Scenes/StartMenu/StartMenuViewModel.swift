//
//  StartMenuViewModel.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Foundation

struct StartMenuViewModel {

    var difficulty: Level = .medium
    var userIsAuthenticated = false

    mutating func chooseDifficulty(level: Level) {
        difficulty = level
    }
}
