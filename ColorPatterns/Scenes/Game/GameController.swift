//
//  GameController.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

protocol GamePresentable {
    func updateTimeLabel(seconds: Int)
    func updateScoreLabel(score: Int)
    func navigateToGameOver(userScore: Score, level: Level)
}

final class GameController: UIViewController {

    @IBOutlet private var colorBars: [UIButton]!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!

    private let viewModel: GameViewModel

    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var prefersStatusBarHidden: Bool {
      return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateColorBars()
        viewModel.startTimer()
    }

    @IBAction private func colorBarPressed(_ sender: UIButton) {
        guard let buttonId = sender.accessibilityLabel else { return }
        guard let barNumber = Int(buttonId) else { return }
        viewModel.didPressColorBar(colorBar: barNumber)
        updateColorBars()
    }

    @IBAction private func didSwipeDown(_ sender: UISwipeGestureRecognizer) {
        viewModel.didSwipeDown()
        updateColorBars()
    }
}

extension GameController: GamePresentable {

    func updateTimeLabel(seconds: Int) {
        timeLabel.text = seconds.toString
    }

    func updateScoreLabel(score: Int) {
        scoreLabel.text = score.toString
    }

    func navigateToGameOver(userScore: Score, level: Level) {
        let gameOverController = GameOverCreator().getController(score: userScore,
                                                                 level: level,
                                                                 gameController: self)
        gameOverController.modalPresentationStyle = .fullScreen
        self.present(gameOverController, animated: true, completion: nil)
    }
}

private extension GameController {

    private func updateColorBars() {
        let randomColors = viewModel.shuffleColors()
        colorBars.enumerated().forEach {
            $1.backgroundColor = randomColors[$0]
        }
    }
}
