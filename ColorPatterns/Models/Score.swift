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
    
    //  Calculate user score if user hit color in range of his picked color
    mutating func calculateScore(_ score: Bool) {
        if score {
            self.score += 1
        } else {
            self.score -= 1
        }
    }
}
