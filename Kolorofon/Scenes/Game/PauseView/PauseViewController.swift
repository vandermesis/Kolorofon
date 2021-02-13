//
//  PauseViewController.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 02/03/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

protocol PauseViewControlerDelegate: class {
    func didPressRestart()
    func didPressBackButton()
}

final class PauseViewController: UIViewController {

    @IBOutlet private weak var scoreLabel: UILabel!

    private var userScore: String

    weak var delegate: PauseViewControlerDelegate?

    init(userScore: String) {
        self.userScore = userScore
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        scoreLabel.text = userScore
    }

    @IBAction private func restartButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: false, completion: delegate?.didPressRestart)
    }

    @IBAction private func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: false, completion: delegate?.didPressBackButton)
    }
}
