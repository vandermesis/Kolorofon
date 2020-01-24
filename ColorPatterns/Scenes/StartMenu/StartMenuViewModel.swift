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

    mutating func chooseDifficultyLevel(button: Int) {
        switch button {
        case 1:
            difficulty = .easy
        case 2:
            difficulty = .medium
        case 3:
            difficulty = .hard
        default:
            difficulty = .medium
        }
    }
}
