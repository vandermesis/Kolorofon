//
//  String+URLConverter.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 11/03/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Foundation

extension String {

    var soundFileToURL: URL? {
        let soundURL = Bundle.main.url(forResource: self, withExtension: Constants.Sounds.audioFormat)
        return soundURL
    }
}
