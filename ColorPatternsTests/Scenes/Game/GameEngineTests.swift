//
//  GameEngineTests.swift
//  ColorPatternsTests
//
//  Created by Marek Skrzelowski on 22/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import ColorPatterns

final class GameEngineTests: QuickSpec {

    override func spec() {

        var gameEngine: GameEngine?

        beforeEach {
            gameEngine = GameEngine()
        }

        describe("setting value of property userColor") {

            beforeEach {
                gameEngine?.userColor = 0.05
            }

            it("should return range of numbers") {
                expect(gameEngine?.colorRange).to(equal(0...0.1))
            }
        }

        describe("on shuffling colors") {

            beforeEach {
                gameEngine?.shuffleColors()
            }

            it("should return array of random CGFloat numbers") {
                expect(gameEngine?.colorsArray).notTo(equal([0, 0, 0, 0, 0]))
            }
        }
    }
}
