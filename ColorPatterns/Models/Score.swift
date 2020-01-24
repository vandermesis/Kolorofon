//
//  User.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Foundation

final class Score {

    var score: Int = 0 {
        didSet {
            score = max(0, score)
        }
    }

    func updateScorePoints(_ shouldIncrease: Bool) {
        self.score += shouldIncrease ? 1 : -1
    }
}
