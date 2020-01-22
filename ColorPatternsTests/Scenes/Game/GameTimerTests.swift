//
//  GameTimerTests.swift
//  ColorPatternsTests
//
//  Created by Marek Skrzelowski on 22/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Quick
import Nimble

@testable import ColorPatterns

final class GameTimerTests: QuickSpec {

    override func spec() {

        var gameTimer: GameTimer!
        var gameController: FakeGameController!

        beforeEach {
            gameTimer = GameTimer()
            gameController = FakeGameController()
            gameTimer.delegate = gameController
        }

        describe("on timer fires") {

            beforeEach {
                gameTimer.start()
            }

            afterEach {
                gameTimer = nil
            }

            it("should reduce timeLeft property by 1") {
                expect(gameTimer.timeLeft).toEventually(beLessThan(60))
            }

            it("should call delegate with updated data") {
                expect(gameController.timerDidUpdateCalled).toEventually(beTrue())
            }

            context("when timer reaches 30") {

                beforeEach {
                    gameTimer.timeLeft = 30
                }

                it("should call delegate that 29 seconds game left") {
                    expect(gameController.timerDidUpdateSecondsCalled).toEventually(equal(29))
                }
            }

            context("when timer reaches zero") {

                beforeEach {
                    gameTimer.timeLeft = 0
                }

                it("should call delegate that game timer did end counting") {
                    expect(gameController.timerDidEndCountingCalled).toEventually(beTrue())
                }

                it("should reset timeLeft property back to 60 seconds") {
                    expect(gameTimer.timeLeft).toEventually(equal(60))
                }
            }
        }
    }
}
