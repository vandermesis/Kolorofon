//
//  GameSounds.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Foundation

final class GameSounds {

    // MARK: Properties

    private let starling = Starling()
    private let gameSounds: [SoundIdentifier] = [.note1, .note2, .note3, .note4, .note5, .note6]
    private let userDefaults: UserDefaults

    // MARK: Object Lifecycle

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        loadSounds()
    }

    // MARK: Actions

    func play(soundFile: Int) {
        guard soundSettingsStatus else { return }
        starling.play(gameSounds[soundFile])
    }

    // MARK: Private

    private func loadSounds() {
        starling.load(resource: Constants.Sounds.note1, type: Constants.Sounds.audioFormat, for: .note1)
        starling.load(resource: Constants.Sounds.note2, type: Constants.Sounds.audioFormat, for: .note2)
        starling.load(resource: Constants.Sounds.note3, type: Constants.Sounds.audioFormat, for: .note3)
        starling.load(resource: Constants.Sounds.note4, type: Constants.Sounds.audioFormat, for: .note4)
        starling.load(resource: Constants.Sounds.note5, type: Constants.Sounds.audioFormat, for: .note5)
        starling.load(resource: Constants.Sounds.note6, type: Constants.Sounds.audioFormat, for: .note6)

    }

    private var soundSettingsStatus: Bool {
        return userDefaults.bool(forKey: Constants.UserDefaultsKeys.sound)
    }

}

extension SoundIdentifier {

    static let note1 = SoundIdentifier("note1")
    static let note2 = SoundIdentifier("note2")
    static let note3 = SoundIdentifier("note3")
    static let note4 = SoundIdentifier("note4")
    static let note5 = SoundIdentifier("note5")
    static let note6 = SoundIdentifier("note6")

}
