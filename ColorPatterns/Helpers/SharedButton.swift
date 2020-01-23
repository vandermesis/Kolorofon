//
//  SharedButton.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 23/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

final class SharedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        privateInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        privateInit()
    }

    private func privateInit() {
        self.layer.cornerRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 7
        self.layer.shadowColor = R.color.backgroundDark()?.cgColor
        self.layer.borderWidth = 1
        self.layer.borderColor = R.color.buttonMain()?.cgColor
    }
}
