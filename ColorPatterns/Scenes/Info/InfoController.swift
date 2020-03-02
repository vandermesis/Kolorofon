//
//  InfoController.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/02/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

final class InfoController: UIViewController {

    private let viewModel: InfoViewModel

    init(viewModel: InfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
