//
//  GameController.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

final class GameController: UIViewController {

    @IBOutlet private var colorBars: [UIButton]!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!

    private let viewModel: GameViewModel
    private var gameTimer: GameTimer
    private var gameSounds: GameSounds
    private var userDefaults: UserDefaults

    init(viewModel: GameViewModel,
         timer: GameTimer,
         sounds: GameSounds,
         userDefaults: UserDefaults) {
        self.viewModel = viewModel
        self.gameTimer = timer
        self.gameSounds = sounds
        self.userDefaults = userDefaults

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
        setupGameTimer()
        setupViewModelDelegate()
        setupScoreLabel()
    }

    @IBAction private func colorBarPressed(_ sender: UIButton) {
        // TODO: Try not to use tags, make an another way to identify buttons
        viewModel.didPressColorBar(colorBar: sender.tag - 1)
        updateColorBars()
        playSound(soundFile: sender.tag - 1)
    }
    @IBAction private func didSwipeDown(_ sender: UISwipeGestureRecognizer) {
        updateColorBars()
    }
}

private extension GameController {

    private func setupGameTimer() {
        // TODO: You can move timer to viewmodel
        timeLabel.text = gameTimer.timeLeft.toString
        gameTimer.start()
        gameTimer.delegate = self
    }

    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }

    private func setupScoreLabel() {
        scoreLabel.text = 0.toString
    }
}

private extension GameController {

    private func updateColorBars() {
        let updatedColors = viewModel.shuffleColors()
        colorBars.enumerated().forEach {
            $1.backgroundColor = updatedColors[$0].uiColorFromCGFloat
        }
    }

    private func playSound(soundFile: Int) {
        // TODO: Make a helper class that does all that stuff
        if userDefaults.bool(forKey: Constants.UserDefaultsKeys.sound) == true {
            gameSounds.play(soundFile: soundFile)
        }
    }
}

extension GameController: GameTimerDelegate {

    func timerDidEndCounting() {
        let userScore = viewModel.userScore
        let gameOverController = GameOverCreator().getController(score: userScore)
        gameOverController.modalPresentationStyle = .fullScreen
        self.present(gameOverController, animated: true, completion: nil)
    }

    func timerDidUpdate(seconds: Int) {
        timeLabel.text = seconds.toString
    }
}

extension GameController: GameViewModelDelegate {

    func didUpdateScore(score: Int) {
        scoreLabel.text = score.toString
    }
}
