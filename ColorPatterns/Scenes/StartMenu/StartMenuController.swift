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

    var viewModel: StartMenuViewModel

    init(viewModel: StartMenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction private func difficultyButtonPressed(_ sender: UIButton) {
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
        let selectedButton = difficultyButton[button]
        let unselectedButtons = difficultyButton.filter { $0 != selectedButton }
        selectedButton.backgroundColor = R.color.buttonMain()
        selectedButton.setTitleColor(R.color.textLightMain(), for: .normal)
        unselectedButtons.forEach { button in
            button.backgroundColor = R.color.buttonSecond()
            button.setTitleColor(R.color.textDarkMain(), for: .normal)
        }
    }
}
