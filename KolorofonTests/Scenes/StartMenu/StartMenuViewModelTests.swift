//
//  StartMenuViewModelTests.swift
//  ColorPatternsTests
//
//  Created by Marek Skrzelowski on 24/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Quick
import Nimble

@testable import ColorPatterns

final class StartMenuViewModelTests: QuickSpec {

    override func spec() {

        var viewModel: StartMenuViewModel!

        beforeEach {
            viewModel = StartMenuViewModel()
        }

        describe("choosing difficulty level") {

            context("button Easy") {

                beforeEach {
                    viewModel.chooseDifficulty(level: .easy)
                }

                it("should set difficulty level to easy") {
                    expect(viewModel.difficulty).to(equal(.easy))
                }
            }

            context("button Medium") {

                beforeEach {
                    viewModel.chooseDifficulty(level: .medium)
                }

                it("should set difficulty level to medium") {
                    expect(viewModel.difficulty).to(equal(.medium))
                }
            }

            context("button Hard") {

                beforeEach {
                    viewModel.chooseDifficulty(level: .hard)
                }

                it("should set difficulty level to hard") {
                    expect(viewModel.difficulty).to(equal(.hard))
                }
            }

            context("button not pressed") {

                it("should set difficulty level to medium") {
                    expect(viewModel.difficulty).to(equal(.medium))
                }
            }
        }
    }
}
