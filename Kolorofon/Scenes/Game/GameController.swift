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
    func updateMultiplierLabel(multiplier: Int)
    func navigateToGameOver(userScore: Score, level: Level)
}

final class GameController: UIViewController {

    @IBOutlet private var colorBars: [UIButton]!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var scoreMultiplierLabel: UILabel!

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
        setupNotifications()
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
    @IBAction private func didSwipeUp(_ sender: UISwipeGestureRecognizer) {
        presentPauseController()
        viewModel.pauseTimer()
    }
}

private extension GameController {

    private func updateColorBars() {
        let randomColors = viewModel.shuffleColors()
        colorBars.enumerated().forEach {
            $1.backgroundColor = randomColors[$0]
        }
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(pauseTimer),
                                               name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(startTimer),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }

    @objc private func pauseTimer() {
        viewModel.pauseTimer()
    }

    @objc private func startTimer() {
        viewModel.startTimer()
    }

    private func presentPauseController() {
        guard let currentScore = scoreLabel.text else { return }
        let pauseController = PauseViewController(userScore: currentScore)
        pauseController.delegate = self
        pauseController.modalPresentationStyle = .overFullScreen
        present(pauseController, animated: false, completion: nil)
    }
}

extension GameController: GamePresentable {

    func updateTimeLabel(seconds: Int) {
        timeLabel.text = seconds.toString
    }

    func updateScoreLabel(score: Int) {
        scoreLabel.text = score.toString
    }

    func updateMultiplierLabel(multiplier: Int) {
        scoreMultiplierLabel.text = multiplier.toMultiplierString
    }

    func navigateToGameOver(userScore: Score, level: Level) {
        let gameOverController = GameOverCreator().getController(score: userScore,
                                                                 level: level,
                                                                 gameController: self)
        gameOverController.modalPresentationStyle = .fullScreen
        self.present(gameOverController, animated: false, completion: nil)
    }
}

extension GameController: PauseViewControlerDelegate {
    func didPressRestart() {
        viewModel.startTimer()
    }

    func didPressBackButton() {
        self.dismiss(animated: false, completion: nil)
    }
}
