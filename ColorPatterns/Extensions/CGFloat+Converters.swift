//
//  CGFloat+Converters.swift
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

    func randomCGFloatWithDecimalPlaces(count: Int) -> CGFloat {
        let decimalPlaces = "%.\(count)f"
        let stringWithDecimalPlaces = String(format: decimalPlaces, randomCGFloatForHue) as NSString
        let doubleFromString = stringWithDecimalPlaces.doubleValue
        return CGFloat(doubleFromString)
    }
}

private extension CGFloat {

    private var randomCGFloatForHue: CGFloat {
        return CGFloat.random(in: 0.0...0.999)
    }
}
