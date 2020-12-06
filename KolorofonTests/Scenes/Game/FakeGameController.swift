//
//  FakeGameController.swift
//  ColorPatternsTests
//
//  Created by Marek Skrzelowski on 22/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

@testable import ColorPatterns

final class FakeGameController: UIViewController {

    var timerDidEndCountingCalled: Bool?
    var timerDidUpdateCalled: Bool?
    var timerDidUpdateSecondsCalled: Int?

}

extension FakeGameController: GameTimerDelegate {

    func timerDidEndCounting() {
        timerDidEndCountingCalled = true
    }

    func timerDidUpdate(seconds: Int) {
        timerDidUpdateCalled = true
        timerDidUpdateSecondsCalled = seconds
    }
}
