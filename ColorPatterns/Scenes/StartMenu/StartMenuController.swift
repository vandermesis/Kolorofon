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

    override func viewDidLoad() {
        setupNotifications()
        setupSegmentedControl()
        setupLottieView(animation: .lottieAnimation)
    }

    override func viewWillAppear(_ animated: Bool) {
        startAnimation()
        viewModel.checkGameCenterStatus()
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

private extension StartMenuController {

    private func setupLottieView(animation: String) {
        lottieView?.animation = Animation.named(animation)
        lottieView?.loopMode = .loop
        lottieView?.animationSpeed = 1
    }

    private func presentGameCenterController() {
        let gameCenterController = GKGameCenterViewController()
        gameCenterController.gameCenterDelegate = self
        gameCenterController.viewState = .leaderboards
        gameCenterController.leaderboardIdentifier = viewModel.difficulty.leaderboardForLevel
        present(gameCenterController, animated: false, completion: nil)
    }

    private func setupSegmentedControl() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: R.color.textTertiary() as Any,
                                                 NSAttributedString.Key.font: UIFont(name: .trebuchetMS,
                                                                                     size: .difficultyControlFontSize) as Any], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                                 NSAttributedString.Key.font: UIFont(name: .trebuchetMS,
                                                                                     size: .difficultyControlFontSize) as Any], for: .normal)
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(startAnimation),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }

    @objc private func startAnimation() {
        lottieView.play()
    }
}

extension StartMenuController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}

private extension String {

    static let trebuchetMS = "Trebuchet MS"
    static let lottieAnimation = "990-inattentive"
}

private extension CGFloat {

    static let difficultyControlFontSize: CGFloat = 20
}
