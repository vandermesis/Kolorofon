//
//  GameCreatorTests.swift
//  ColorPatternsTests
//
//  Created by Marek Skrzelowski on 22/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Quick
import Nimble

@testable import ColorPatterns

final class GameCreatorTests: QuickSpec {

    override func spec() {

        var controller: UIViewController?

        describe("getting GameController") {

            beforeEach {
                controller = GameCreator().getController(difficulty: .medium)
            }

            afterEach {
                controller = nil
            }

            it("should return valid controller") {
                expect(controller).to(beAKindOf(GameController.self))
            }
        }
    }
}
