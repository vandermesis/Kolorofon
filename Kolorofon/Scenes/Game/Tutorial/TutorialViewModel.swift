//
//  TutorialViewModel.swift
//  Kolorofon
//
//  Created by Marek Skrzelowski on 04/04/2021.
//  Copyright © 2021 vandermesis. All rights reserved.
//

import Foundation

protocol TutorialViewModel {
    var currentStep: Int { get set }
    func getTutorialMessage() -> String?
    func makeNextStep()
}

final class TutorialViewModelImpl {

    weak var controller: TutorialController?

    var currentStep: Int

    private var tutorialSteps: [String] = [
        R.string.localizable.tutorialStep0(),
        R.string.localizable.tutorialStep1(),
        R.string.localizable.tutorialStep2(),
        R.string.localizable.tutorialStep3(),
        R.string.localizable.tutorialStep4(),
        R.string.localizable.tutorialStep5(),
        R.string.localizable.tutorialStep6(),
        R.string.localizable.tutorialStep7(),
        R.string.localizable.tutorialStep8()
    ]

    init(mode: Mode) {
        self.currentStep = mode.rawValue
    }

}

extension TutorialViewModelImpl: TutorialViewModel {

    func getTutorialMessage() -> String? {
        guard currentStep < 9 else {
            return nil
        }
        return tutorialSteps[currentStep]
    }

    func makeNextStep() {
        currentStep += 1
    }

}
