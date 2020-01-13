//
//  User.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Foundation

struct Score {

    var score: Int = 0 {
        didSet {
            guard score > 0 else {
                return score = 0
            }
        }
    }

    mutating func addScorePoints(_ score: Bool) {
        if score {
            self.score += 1
        } else {
            self.score -= 1
        }
    }
}
