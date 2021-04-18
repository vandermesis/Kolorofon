//
//  Array+SafeValue.swift
//  Kolorofon
//
//  Created by Marek on 05/04/2021.
//  Copyright © 2021 vandermesis. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }
}
