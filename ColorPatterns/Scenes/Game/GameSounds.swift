//
//  GameSounds.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import AVFoundation

final class GameSounds {

    private var audioPlayer: AVAudioPlayer?

    private let userDefaults: UserDefaults

    private let soundsArray = [Constants.Sounds.note1,
                               Constants.Sounds.note2,
                               Constants.Sounds.note3,
                               Constants.Sounds.note4,
                               Constants.Sounds.note5]

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
}

extension GameSounds {

    func play(soundFile: Int) {
        guard soundSettingsStatus else { return }
        guard let soundURL = Bundle.main.url(forResource: soundsArray[soundFile],
                                             withExtension: Constants.Sounds.wavFormat) else { return }
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print("Error in \(#function): \(error.localizedDescription)")
        }
        audioPlayer?.play()
    }
}

private extension GameSounds {

    private var soundSettingsStatus: Bool {
        return userDefaults.bool(forKey: Constants.UserDefaultsKeys.sound)
    }
}
