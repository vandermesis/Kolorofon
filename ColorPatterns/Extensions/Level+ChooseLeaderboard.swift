//
//  Level+ChooseLeaderboard.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 12/02/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Foundation

extension Level {

    var leaderboardForLevel: String {
        switch self {
        case .easy:
            return Constants.GameCenter.easyLeaderBoardID
        case .medium:
            return Constants.GameCenter.mediumLeaderBoardID
        case .hard:
            return Constants.GameCenter.hardLeaderBoardID
        }
    }
}
