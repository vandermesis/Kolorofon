//
//  GameOverViewModel.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Foundation
import GameKit

struct GameOverViewModel {

    let userScore: Score
    let level: Level

    init(userScore: Score, level: Level) {
        self.userScore = userScore
        self.level = level
    }

    func submitScoreToGameCenter() {
        let leaderboardForLevel = level.leaderboardForLevel
        let bestScore = GKScore(leaderboardIdentifier: leaderboardForLevel)
        bestScore.value = Int64(userScore.score)
        GKScore.report([bestScore]) { error in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                print("Best score submitted successfully")
            }
        }
    }
}
