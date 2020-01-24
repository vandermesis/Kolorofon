//
//  CGFloat+Converters.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

extension CGFloat {

    // It's ok, but from my experience I can tell you that It's always a better idea to have your own set of colors and random from those. In most of cases random colors are ugly, and you can get simmilar-looking colors. Find a nice palete of raindbow saturated colors / or make your own and randomize from there :)
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
