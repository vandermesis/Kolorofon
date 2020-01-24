//
//  GameEngine.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 12/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import UIKit

enum Level: Int {
    case easy = 1
    case medium = 2
    case hard = 3
}

final class GameEngine {

    private let level: Level
    
    var colorsArray = [CGFloat](repeating: 0.0, count: 5)
    var pickedColor: CGFloat = 0
    var userColor: CGFloat = 0
    var colorRange: ClosedRange<CGFloat> {
        return userColor-0.05...userColor+0.05
    }

    init(level: Level) {
        self.level = level
    }
}

extension GameEngine {

    func shuffleColors() -> [CGFloat] {
        colorsArray = colorsArray.map { $0.randomCGFloatWithDecimalPlaces(count: level.rawValue) }
        return colorsArray
    }
}
