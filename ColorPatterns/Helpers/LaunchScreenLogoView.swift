//
//  LaunchScreenLogoView.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 26/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

final class LaunchScreenLogoView: UIView {

    @IBOutlet private var logoView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setupView() {
        Bundle.main.loadNibNamed("LaunchScreenLogoView", owner: self, options: nil)
        addSubview(logoView)
    }
}
