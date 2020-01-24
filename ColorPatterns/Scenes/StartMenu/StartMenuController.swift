//
//  StartMenuController.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

class StartMenuController: UIViewController {

    @IBOutlet private var levelLabel: [SharedButton]!

    let viewModel: StartMenuViewModel

    init(viewModel: StartMenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func levelButtonPressed(_ sender: UIButton) {
        setupLevelButtonColor(button: sender.tag - 1)
    }

    @IBAction private func startButtonPressed(_ sender: UIButton) {
        let gameController = GameCreator().getController()
        gameController.modalPresentationStyle = .fullScreen
        present(gameController, animated: true, completion: nil)
    }
}

private extension StartMenuController {

    private func setupLevelButtonColor(button: Int) {
        levelLabel[button].backgroundColor = R.color.buttonMain()
        levelLabel[button].setTitleColor(R.color.textLightMain(), for: .normal)
    }
}
