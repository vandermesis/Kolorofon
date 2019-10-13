//
//  User.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Foundation

struct User {
    
    var score: Int = 0 {
        didSet {
            if score < 0 {
                score = 0
            }
        }
    }
}
