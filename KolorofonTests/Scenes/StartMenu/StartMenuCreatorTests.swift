//
//  StartMenuCreatorTests.swift
//  ColorPatternsTests
//
//  Created by Marek Skrzelowski on 24/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Quick
import Nimble

@testable import ColorPatterns

final class StartMenuCreatorTests: QuickSpec {

    override func spec() {

        var controller: UIViewController!

        describe("getting GameController") {

            beforeEach {
                controller = StartMenuCreator().getController()
            }

            afterEach {
                controller = nil
            }

            it("should return valid controller") {
                expect(controller).to(beAKindOf(StartMenuController.self))
            }
        }
    }
}
