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
    private var defaults: UserDefaults

    init(viewModel: GameViewModel,
         timer: GameTimer,
         sounds: GameSounds,
         userDefaults: UserDefaults) {
        self.viewModel = viewModel
        self.gameTimer = timer
        self.gameSounds = sounds
        self.defaults = userDefaults

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
        setupSwipeDownGesture(direction: .down)
        setupGameTimer()
        setupViewModelDelegate()
    }

    @IBAction private func colorBarPressed(_ sender: UIButton) {
        viewModel.didPressColorBar(colorBar: sender.tag - 1)
        updateColorBars()
        playSound(soundFile: sender.tag - 1)
    }
}

private extension GameController {

    private func setupGameTimer() {
        timeLabel.text = gameTimer.timeLeft.formatToString
        gameTimer.start()
        gameTimer.delegate = self
    }

    private func setupViewModelDelegate() {
        scoreLabel.text = 0.formatToString
        viewModel.delegate = self
    }
}

private extension GameController {

    private func updateColorBars() {
        let updatedColors = viewModel.shuffleColors()
        colorBars.enumerated().forEach {
            $1.backgroundColor = updatedColors[$0].uiColorFromCGFloat
        }
    }

    private func setupSwipeDownGesture(direction: UISwipeGestureRecognizer.Direction) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGesture.direction = direction
        view.addGestureRecognizer(swipeGesture)
    }

    @objc func didSwipe(_ sender: UISwipeGestureRecognizer) {
        updateColorBars()
    }

    private func playSound(soundFile: Int) {
        if defaults.bool(forKey: K.DefaultsKeys.sound) == true {
            gameSounds.play(soundFile: soundFile)
        }
    }
}

extension GameController: GameTimerDelegate {

    func timerDidEndCounting() {
        print("Game Over")
    }

    func timerDidUpdate(seconds: Int) {
        timeLabel.text = seconds.formatToString
    }
}

extension GameController: GameViewModelDelegate {

    func didUpdateScore(score: Int) {
        scoreLabel.text = score.formatToString
    }
}
