//
//  TutorialController.swift
//  Kolorofon
//
//  Created by Marek on 03/04/2021.
//  Copyright © 2021 vandermesis. All rights reserved.
//

import UIKit

protocol TutorialControllerDelegate: class {
    func didPressNextIn(step: Int)
    func didFinishTutorial()
    func didPressQuit()
}

final class TutorialController: UIViewController {

    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!

    private var viewModel: TutorialViewModel

    weak var delegate: TutorialControllerDelegate?

    init(viewModel: TutorialViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupViewForCurrentStep()
    }

    @IBAction private func nextButtonPressed(_ sender: UIButton) {
        viewModel.makeNextStep()
        setupViewForCurrentStep()
        delegate?.didPressNextIn(step: viewModel.currentStep)
    }
    
    @IBAction private func quitButtonPressed(_ sender: UIButton) {
        dismiss(animated: false) { [self] in
            delegate?.didPressQuit()
        }
    }

    private func setupViewForCurrentStep() {
        guard let tutorialStep = viewModel.getTutorialStep() else {
            dismiss(animated: false) {
                self.delegate?.didFinishTutorial()
            }
            return
        }
        messageLabel.text = tutorialStep.message
        iconImageView.image = tutorialStep.image
    }

}
