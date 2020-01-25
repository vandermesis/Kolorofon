//
//  FakeGameTimer.swift
//  ColorPatternsTests
//
//  Created by Marek Skrzelowski on 25/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Foundation

@testable import ColorPatterns

final class FakeGameTimer: GameTimer {

    var startCalled: Bool?

    func start() {
        startCalled = true
    }
}
