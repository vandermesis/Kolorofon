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

    weak var delegate: PauseViewControlerDelegate?

    @IBAction private func restartButtonPressed(_ sender: SharedButton) {
        self.dismiss(animated: false, completion: delegate?.didPressRestart)
    }

    @IBAction private func backButtonPressed(_ sender: SharedButton) {
        self.dismiss(animated: false, completion: delegate?.didPressBackButton)
    }
}
