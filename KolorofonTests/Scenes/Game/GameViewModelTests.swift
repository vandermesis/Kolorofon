//
//  GameViewModelTests.swift
//  ColorPatternsTests
//
//  Created by Marek Skrzelowski on 22/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Quick
import Nimble

@testable import Kolorofon

final class GameViewModelTests: QuickSpec {

    override func spec() {

        var gameEngine: GameEngine!
        var gameTimer: FakeGameTimer!
        var gameSounds: GameSounds!
        var userScore: Score!
        var viewModel: GameViewModel!

        beforeEach {
            gameEngine = GameEngine(level: .medium)
            gameTimer = FakeGameTimer()
            gameSounds = GameSounds(userDefaults: UserDefaults.standard)
            userScore = Score()
            viewModel = GameViewModelImpl(mode: .game,
                                          gameEngine: gameEngine,
                                          gameTimer: gameTimer,
                                          gameSounds: gameSounds,
                                          score: userScore,
                                          defaults: UserDefaults.standard)
        }

        describe("starting Timer") {

            beforeEach {
                gameTimer.start()
            }

            it("should call timer to start counting") {
                expect(gameTimer.startCalled).to(beTrue())
            }
        }

        describe("pressing color bar") {

            beforeEach {
                gameEngine.randomColorsArray = [.black, .white, .red, .green, .blue]
                viewModel.didPressColorBar(colorBar: 1)
            }

            it("should call game engine save picked color") {
                expect(gameEngine.pickedColor).to(equal(gameEngine.randomColorsArray[1]))
            }

            it("should call userScore to get score 0") {
                expect(userScore.score).to(equal(0))
            }

            it("should call game engine to save user color") {
                expect(gameEngine.userColor).to(equal(gameEngine.pickedColor))
            }

            context("after game started") {

                context("and user picked his color") {

                    beforeEach {
                        userScore.score = 4
                        viewModel.didPressColorBar(colorBar: 1)
                    }

                    it("should call userScore to add 1 score point") {
                        expect(userScore.score).to(equal(5))
                    }
                }

                context("and user not picked his color") {

                    beforeEach {
                        userScore.score = 4
                        viewModel.didPressColorBar(colorBar: 2)
                    }

                    it("shoul call userScore to subtract 1 score point") {
                        expect(userScore.score).to(equal(3))
                    }
                }
            }
        }
    }
}
