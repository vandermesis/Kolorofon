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
        setupSwipeDownGesture(direction: .down)
    }

    @IBAction private func colorBarPressed(_ sender: UIButton) {
        viewModel.didPressColorBar(colorBar: sender.tag - 1)
        updateColorBars()
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
}


