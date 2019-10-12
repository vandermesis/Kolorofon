//
//  UpdateColors.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 12/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import UIKit

struct UpdateColors {
    
    var colorsArray = [CGFloat](repeating: 0.0, count: 5)
    
    
    mutating func shuffle() -> [CGFloat] {
        colorsArray = colorsArray.map {_ in CGFloat((String(format: "%.2f", CGFloat.random(in: 0.0...0.9)) as NSString).doubleValue)}
        return colorsArray
    }
        
}
