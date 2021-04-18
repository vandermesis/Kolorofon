//
//  User.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Foundation

final class Score {

    var winningStreak: Int = 0
    var scoreMultiplier: Int {
        switch winningStreak {
        case 0...4:
            return 1
        case 5...9:
            return 2
        case 10...19:
            return 3
        case 20...29:
            return 4
        case 30...39:
            return 5
        case 40...49:
            return 6
        case 50...59:
            return 7
        case 60...69:
            return 8
        case 70...79:
            return 9
        default:
            return 10
        }
    }
    var score: Int = 0 {
        didSet {
            score = max(0, score)
        }
    }

    func updateScorePoints(_ shouldUpdate: Bool) {
        if shouldUpdate {
            self.score += (scoreMultiplier * 1)
            winningStreak += 1
        } else {
            self.score += (scoreMultiplier * -1)
            winningStreak = 0
        }
    }
}
