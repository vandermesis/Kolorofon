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
}

final class GameEngine {

    var randomColorsArray = [UIColor](repeating: .white, count: 5)
    var pickedColor: UIColor = .white
    var userColor: UIColor = .white

    let level: Level

    init(level: Level) {
        self.level = level
    }
}

extension GameEngine {

    func getRandomColors() -> [UIColor] {
        randomColorsArray = randomColorsArray.map { $0.randomColorForLevel(level: level) }
        return randomColorsArray
    }
}
