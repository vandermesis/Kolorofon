//
//  GameOverCreatorTests.swift
//  ColorPatternsTests
//
//  Created by Marek Skrzelowski on 23/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Quick
import Nimble

@testable import ColorPatterns

final class GameOverCreatorTests: QuickSpec {

    override func spec() {

        var level: Level!
        var controller: UIViewController!
        var score: Score!
        var fakeController: UIViewController!

        describe("getting GameController") {

            beforeEach {
                score = Score()
                level = .easy
                fakeController = UIViewController()
                controller = GameOverCreator().getController(score: score, level: level, gameController: fakeController)
            }

            afterEach {
                controller = nil
            }

            it("should return valid controller") {
                expect(controller).to(beAKindOf(GameOverController.self))
            }
        }
    }
}
