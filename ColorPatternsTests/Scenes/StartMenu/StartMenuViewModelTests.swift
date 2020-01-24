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
                    viewModel.chooseDifficultyLevel(button: 1)
                }

                it("should set difficulty level to easy") {
                    expect(viewModel.difficulty).to(equal(.easy))
                }
            }

            context("button Medium") {

                beforeEach {
                    viewModel.chooseDifficultyLevel(button: 2)
                }

                it("should set difficulty level to medium") {
                    expect(viewModel.difficulty).to(equal(.medium))
                }
            }

            context("button Hard") {

                beforeEach {
                    viewModel.chooseDifficultyLevel(button: 3)
                }

                it("should set difficulty level to hard") {
                    expect(viewModel.difficulty).to(equal(.hard))
                }
            }

            context("button not pressed") {
                
                beforeEach {
                    viewModel.chooseDifficultyLevel(button: 0)
                }

                it("should set difficulty level to medium") {
                    expect(viewModel.difficulty).to(equal(.medium))
                }
            }
        }
    }
}
