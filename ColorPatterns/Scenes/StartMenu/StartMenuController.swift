//
//  StartMenuController.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

final class StartMenuController: UIViewController {

    @IBOutlet private var difficultyButton: [SharedButton]!

    private var viewModel: StartMenuViewModel

    init(viewModel: StartMenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction private func difficultyButtonPressed(_ sender: UIButton) {
        // TODO: it's not a good idea to use tags to do such things I'd go with enum difficulty: easy, med, hard and setup buttons with these values, but not use tags
        // you could have these in viewmodel then
        setupDifficultyButtonColor(button: sender.tag - 1)
        viewModel.chooseDifficultyLevel(button: sender.tag)
    }

    @IBAction private func startButtonPressed(_ sender: UIButton) {
        let gameController = GameCreator().getController(difficulty: viewModel.difficulty)
        gameController.modalPresentationStyle = .fullScreen
        present(gameController, animated: true, completion: nil)
    }
}

private extension StartMenuController {

    private func setupDifficultyButtonColor(button: Int) {
        // TODO: crash if I do:  setupDifficultyButtonColor(button: 52) - this should be forbidden
        let selectedButton = difficultyButton[button]
        let unselectedButtons = difficultyButton.filter { $0 != selectedButton }
        selectedButton.backgroundColor = R.color.buttonPrimary()
        selectedButton.setTitleColor(R.color.textTertiary(), for: .normal)
        unselectedButtons.forEach { button in
            button.backgroundColor = R.color.buttonSecondary()
            button.setTitleColor(R.color.textPrimary(), for: .normal)
        }
    }
}
