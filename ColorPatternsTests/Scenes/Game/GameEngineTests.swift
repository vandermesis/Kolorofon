//
//  GameEngineTests.swift
//  ColorPatternsTests
//
//  Created by Marek Skrzelowski on 22/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Quick
import Nimble

@testable import ColorPatterns

final class GameEngineTests: QuickSpec {

    override func spec() {

        var gameEngine: GameEngine?

        beforeEach {
            gameEngine = GameEngine(level: .easy)
        }

        describe("on shuffling colors") {

            beforeEach {
                _ = gameEngine?.shuffleColors()
            }

            it("should return array of random CGFloat numbers") {
                expect(gameEngine?.randomColorsArray).notTo(contain(.white))
            }
        }
    }
}
