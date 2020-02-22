//
//  SharedColorTile.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 22/02/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import UIKit

final class SharedColorTile: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        privateInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        privateInit()
    }

    private func privateInit() {
        self.layer.cornerRadius = 10
    }
}
