//
//  TutorialViewModel.swift
//  Kolorofon
//
//  Created by Marek Skrzelowski on 04/04/2021.
//  Copyright © 2021 vandermesis. All rights reserved.
//

import UIKit

protocol TutorialViewModel {
    var currentStep: Int { get set }
    func getTutorialStep() -> (message: String, image: UIImage?)?
    func makeNextStep()
}

final class TutorialViewModelImpl {

    weak var controller: TutorialController?

    var currentStep: Int

    private var tutorialSteps: [(String, UIImage?)] = [
        (R.string.localizable.tutorialStep0(), R.image.tutorialStep0()),
        (R.string.localizable.tutorialStep1(), R.image.tutorialStep1()),
        (R.string.localizable.tutorialStep2(), R.image.tutorialStep2()),
        (R.string.localizable.tutorialStep3(), R.image.tutorialStep3()),
        (R.string.localizable.tutorialStep4(), R.image.tutorialStep4()),
        (R.string.localizable.tutorialStep5(), R.image.tutorialStep5()),
        (R.string.localizable.tutorialStep6(), R.image.tutorialStep6()),
        (R.string.localizable.tutorialStep7(), R.image.tutorialStep7()),
        (R.string.localizable.tutorialStep8(), R.image.tutorialStep8())
    ]

    init(mode: Mode) {
        self.currentStep = mode.rawValue
    }

}

extension TutorialViewModelImpl: TutorialViewModel {

    func getTutorialStep() -> (message: String, image: UIImage?)? {
        guard let step = tutorialSteps[safe: currentStep] else { return nil }
        return step
    }

    func makeNextStep() {
        currentStep += 1
    }

}
