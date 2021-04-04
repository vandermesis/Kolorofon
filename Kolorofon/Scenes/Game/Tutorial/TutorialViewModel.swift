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

    private let userDefaults: UserDefaults

    weak var controller: TutorialController?

    var currentStep: Int

    private var mode: Mode
    private var tutorialSteps: [String] = [
        R.string.localizable.tutorialStep0(),
        R.string.localizable.tutorialStep1(),
        R.string.localizable.tutorialStep2(),
        R.string.localizable.tutorialStep3(),
        R.string.localizable.tutorialStep4(),
        R.string.localizable.tutorialStep5(),
        R.string.localizable.tutorialStep6(),
        R.string.localizable.tutorialStep7()]

    init(mode: Mode, userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        self.mode = mode
        self.currentStep = mode.rawValue
    }

}

extension TutorialViewModelImpl: TutorialViewModel {

    func getTutorialMessage() -> String? {
        guard currentStep < 7 else {
            return nil
        }
        switch mode {
        case .tutorial:
            return tutorialSteps[currentStep]
        case .game:
            saveFirstGamePlayed()
            return tutorialSteps[currentStep]
        }
    }

    func makeNextStep() {
        currentStep += 1
    }

    private func saveFirstGamePlayed() {
        userDefaults.set(true, forKey: Constants.UserDefaultsKeys.firstGamePlayed)
    }
}
