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

        var controller: UIViewController!
        var score: Score!
        var fakeController: UIViewController!

        describe("getting GameController") {

            beforeEach {
                score = Score()
                fakeController = UIViewController()
                controller = GameOverCreator().getController(score: score, gameController: fakeController)
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
