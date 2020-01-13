//
//  ColorPatternsTests.swift
//  ColorPatternsTests
//
//  Created by Marek Skrzelowski on 19/06/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import XCTest

@testable import ColorPatterns

final class ColorPatternsTests: XCTestCase {

    var colors = Colors()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        self.measure {
            _ = colors.shuffle()
        }
    }
}
