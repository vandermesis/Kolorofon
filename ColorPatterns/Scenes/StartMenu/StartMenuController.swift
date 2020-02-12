//
//  StartMenuController.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit
import Lottie
import GameKit

final class StartMenuController: UIViewController {

    @IBOutlet private var difficultyButton: [SharedButton]!
    @IBOutlet private weak var lottieView: AnimationView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!

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
        setupLottieView(animation: "990-inattentive")
        setupSegmentedControll()
        checkGameCenterStatus()
    }

    @IBAction private func startButtonPressed(_ sender: UIButton) {
        let gameController = GameCreator().getController(difficulty: viewModel.difficulty)
        gameController.modalPresentationStyle = .fullScreen
        present(gameController, animated: true, completion: nil)

    }
    @IBAction private func difficultySegmentChanged(_ sender: UISegmentedControl) {
        let selectedSegment = sender.selectedSegmentIndex
        guard let segmentTitle = sender.titleForSegment(at: selectedSegment) else { return }
        guard let difficulty = Level(rawValue: segmentTitle.lowercased()) else { return }
        viewModel.chooseDifficulty(level: difficulty)
    }
    @IBAction private func bestScoresButtonPressed(_ sender: UIButton) {
        presentGameCenterController()
    }

}

extension StartMenuController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}

private extension StartMenuController {

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

    private func setupLottieView(animation: String) {
        lottieView?.animation = Animation.named(animation)
        lottieView?.loopMode = .loop
        lottieView?.animationSpeed = 1
        lottieView?.play()
    }

    private func presentGameCenterController() {
        let gameCenterController = GKGameCenterViewController()
        gameCenterController.gameCenterDelegate = self
        gameCenterController.viewState = .leaderboards
        gameCenterController.leaderboardIdentifier = viewModel.difficulty.leaderboardForLevel
        present(gameCenterController, animated: false, completion: nil)
    }

    private func setupSegmentedControll() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: R.color.textTertiary() as Any,
                                                 NSAttributedString.Key.font: UIFont(name: "Trebuchet MS", size: 15) as Any], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                                 NSAttributedString.Key.font: UIFont(name: "Trebuchet MS", size: 15) as Any], for: .normal)
    }

    private func checkGameCenterStatus() {
        if !viewModel.userIsAuthenticated {
            authenticatePlayer()
        }
    }

    private func authenticatePlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = { viewController, error -> Void in
            if let viewController = viewController {
                self.present(viewController, animated: true, completion: nil)
            } else if localPlayer.isAuthenticated {
                self.viewModel.userIsAuthenticated = true
            }
        }
    }
}
