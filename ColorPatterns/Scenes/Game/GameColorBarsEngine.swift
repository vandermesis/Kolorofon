//
//  GameColorBarsEngine.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 12/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import UIKit

enum Level {
    case easy, medium, hard
}

struct GameColorBarsEngine {
    
    var array = [CGFloat](repeating: 0.0, count: 5)
    var pickedColor: CGFloat = 0
    var userColor: CGFloat = 0
    var range: ClosedRange<CGFloat> {
        let range = userColor-0.05...userColor+0.05
        //TODO: Remove when not needed
        print(range)
        return range
    }
}

extension GameColorBarsEngine {

    mutating func shuffleColors() -> [CGFloat] {
        array = array.map {_ in CGFloat((String(format: "%.2f", CGFloat.random(in: 0.0...0.9)) as NSString).doubleValue)}
        return array
    }
}
