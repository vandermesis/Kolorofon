//
//  Error+FriendlyMessage.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 22/01/2020.
//  Copyright © 2020 vandermesis. All rights reserved.
//

import Foundation

struct AudioPlayerError: Error {}

extension Error {

    var developerFriendlyMessage: String {
        if self is AudioPlayerError {
            return R.string.localizable.errorAudioPlayer()
        }
        return "Unknown Error"
    }
}
