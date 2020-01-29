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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentLaunchScreen()
    }
    
    @IBAction private func difficultyButtonPressed(_ sender: UIButton) {
        guard let buttonTitle = sender.currentTitle else { return }
        guard let difficulty = Level(rawValue: buttonTitle.lowercased()) else { return }
        setupDifficultyButtonColor(title: buttonTitle)
        viewModel.chooseDifficulty(level: difficulty)
    }

    @IBAction private func startButtonPressed(_ sender: UIButton) {
        let gameController = GameCreator().getController(difficulty: viewModel.difficulty)
        gameController.modalPresentationStyle = .fullScreen
        present(gameController, animated: true, completion: nil)

    }
}

private extension StartMenuController {

    private func setupDifficultyButtonColor(title: String) {
        difficultyButton.forEach { button in
            if button.currentTitle == title {
                button.backgroundColor = R.color.buttonPrimary()
                button.setTitleColor(R.color.textTertiary(), for: .normal)
            } else {
                button.backgroundColor = R.color.buttonSecondary()
                button.setTitleColor(R.color.textPrimary(), for: .normal)
            }
        }
    }

    private func presentLaunchScreen() {
        guard let storyboardController = R.storyboard.launchScreen().instantiateInitialViewController() else { return }
        storyboardController.modalPresentationStyle = .overFullScreen
        present(storyboardController, animated: false, completion: nil)
        UIView.animate(withDuration: 1,
                       delay: 1,
                       options: .curveEaseOut,
                       animations: { storyboardController.view.alpha = 0 },
                       completion: { _ in storyboardController.dismiss(animated: false, completion: nil)})
    }
}
