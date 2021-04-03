//
//  StartMenuController.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit
import GameKit

final class StartMenuController: UIViewController {

    @IBOutlet private var difficultyButton: [UIButton]!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!

    private var viewModel: StartMenuViewModel

    init(viewModel: StartMenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupSegmentedControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.checkGameCenterStatus()
    }

    // MARK: - Actions

    @IBAction private func tutorialButtonPressed(_ sender: UIButton) {
        let gameController = GameCreator().getController(mode: .tutorial, difficulty: .easy)
        gameController.modalPresentationStyle = .fullScreen
        present(gameController, animated: false, completion: nil)
    }

    @IBAction private func infoButtonPressed(_ sender: UIButton) {
        let infoController = InfoCreator().getController()
        infoController.modalPresentationStyle = .fullScreen
        present(infoController, animated: false, completion: nil)
    }

    @IBAction private func bestScoresButtonPressed(_ sender: UIButton) {
        presentGameCenterController()
    }

    @IBAction private func startButtonPressed(_ sender: UIButton) {
        let gameController = GameCreator().getController(difficulty: viewModel.difficulty)
        gameController.modalPresentationStyle = .fullScreen
        present(gameController, animated: false, completion: nil)
    }

    @IBAction private func difficultySegmentChanged(_ sender: UISegmentedControl) {
        let selectedSegment = sender.selectedSegmentIndex
        guard let segmentTitle = sender.titleForSegment(at: selectedSegment) else { return }
        guard let difficulty = Level(rawValue: segmentTitle.lowercased()) else { return }
        viewModel.chooseDifficulty(level: difficulty)
    }

}

private extension StartMenuController {

    private func presentGameCenterController() {
        let gameCenterController = GKGameCenterViewController()
        gameCenterController.gameCenterDelegate = self
        gameCenterController.viewState = .leaderboards
        gameCenterController.leaderboardIdentifier = viewModel.difficulty.leaderboardForLevel
        present(gameCenterController, animated: false, completion: nil)
    }

    private func setupSegmentedControl() {
        segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: R.color.textTertiary() as Any,
                NSAttributedString.Key.font: R.font.interRegular(size: 14) as Any
            ],
            for: .selected
        )
        segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: R.color.buttonPrimary() as Any,
                NSAttributedString.Key.font: R.font.interRegular(size: 14) as Any],
            for: .normal
        )
    }

}

extension StartMenuController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
