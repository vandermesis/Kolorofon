//
//  UIColor+RandomColor.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 15/02/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

enum HueColor: Double {
    case orange = 0.0833333333333333
    case yellow = 0.166666666666667
    case chartreuse = 0.25
    case green = 0.333333333333333
    case spring = 0.416666666666667
    case cyan = 0.5
    case azure = 0.583333333333333
    case blue = 0.666666666666667
    case violet = 0.75
    case magenta = 0.833333333333333
    case rose = 0.916666666666667
    case red = 1
}

extension UIColor {

    func randomColorForLevel(level: Level) -> UIColor {
        let hueColors: [HueColor] = [.orange, .yellow, .chartreuse, .green, .spring, .cyan, .azure, .blue, .violet, .magenta, .rose, .red]
        let levelPercents: [Double] = [0.4, 0.7, 1.0]
        guard let randomHueColor = hueColors.randomElement() else { return UIColor.white }
        guard let randomSaturationLevel = levelPercents.randomElement() else { return UIColor.white }
        guard let randomBrightnessLevel = levelPercents.randomElement() else { return UIColor.white }
        switch level {
        case .easy:
            return UIColor(hue: randomHueColor.rawValue.toCGFloat,
                           saturation: 1,
                           brightness: 1,
                           alpha: 1)
        case .medium:
            return UIColor(hue: randomHueColor.rawValue.toCGFloat,
                           saturation: randomSaturationLevel.toCGFloat,
                           brightness: 1,
                           alpha: 1)
        case .hard:
            return UIColor(hue: randomHueColor.rawValue.toCGFloat,
                           saturation: randomSaturationLevel.toCGFloat,
                           brightness: randomBrightnessLevel.toCGFloat,
                           alpha: 1)
        }
    }
}
