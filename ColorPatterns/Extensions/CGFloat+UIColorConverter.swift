//
//  CGFloat+UIColorConverter.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

extension CGFloat {

    var uiColorFromCGFloat: UIColor {
        return UIColor(hue: self, saturation: 1, brightness: 1, alpha: 1)
    }
}
