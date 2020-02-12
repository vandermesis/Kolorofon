//
//  Constants.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 21/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Foundation

struct Constants {

    struct Sounds {

        static let note1 = "note1"
        static let note2 = "note2"
        static let note3 = "note3"
        static let note4 = "note4"
        static let note5 = "note5"

        static let wavFormat = "wav"
    }

    struct UserDefaultsKeys {

        static let sound = "Sound"
    }

    struct GameTimer {

        static let gameTime = 180
    }

    struct SettingsBundleKeys {

        static let buildVersionKey = "build_preference"
        static let appVersionKey = "version_preference"
        static let cfBundleVersionStringShort = "CFBundleShortVersionString"
        static let cfBundleVersionString = "CFBundleVersion"
    }

    struct GameCenter {

        static let leaderBoardID = "com.bestscores.colourpatterns"
    }
}
