//
//  GameOverController.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

final class GameOverController: UIViewController {

    @IBOutlet private weak var scoreLabel: UILabel!

    weak var gameController: UIViewController?

    let viewModel: GameOverViewModel

    init(viewModel: GameOverViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScoreLabel()
        viewModel.submitScoreToGameCenter()
    }

    @IBAction private func restartGameButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: false) {
            self.gameController?.dismiss(animated: false, completion: nil)
        }
    }
}

private extension GameOverController {

    private func setupScoreLabel() {
        scoreLabel.text = viewModel.userScore.score.toString
    }
}
