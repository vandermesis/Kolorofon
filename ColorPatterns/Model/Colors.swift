//
//  Colors.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 12/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import UIKit

struct Colors {
    
    var array = [CGFloat](repeating: 0.0, count: 5)
    var pickedColor : CGFloat = 0
    var userColor: [CGFloat] = [0.0] {
        didSet {
            if userColor.count > 1 {
                userColor.remove(at: 1)
            }
        }
    }
    
    mutating func shuffle() -> [CGFloat] {
        array = array.map {_ in CGFloat((String(format: "%.2f", CGFloat.random(in: 0.0...0.9)) as NSString).doubleValue)}
        return array
    }
        
}
