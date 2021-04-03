//
//  TutorialController.swift
//  Kolorofon
//
//  Created by Marek on 03/04/2021.
//  Copyright © 2021 vandermesis. All rights reserved.
//

import UIKit

final class TutorialController: UIViewController {

    @IBOutlet private weak var messageLabel: UILabel!

    private var viewModel: TutorialViewModel

    init(viewModel: TutorialViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func quitButtonPressed(_ sender: UIButton) {
    }

}
