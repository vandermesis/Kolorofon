//
//  GameEngine.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 12/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import UIKit

enum Level: String {
    case easy, medium, hard

    var intValue: Int {
        switch self {
        case .easy:
            return 2
        case .medium:
            return 3
        case .hard:
            return 4
        }
    }
}

final class GameEngine {

    var colorsArray = [CGFloat](repeating: 0.0, count: 5)
    var pickedColor: CGFloat = 0
    var userColor: CGFloat = 0
    var colorRange: ClosedRange<CGFloat> {
        return userColor-0.05...userColor+0.05
    }

    let level: Level

    init(level: Level) {
        self.level = level
    }
}

extension GameEngine {

    func shuffleColors() -> [CGFloat] {
        colorsArray = colorsArray.map { $0.randomCGFloatWithDecimalPlaces(count: level.intValue) }
        return colorsArray
    }
}
