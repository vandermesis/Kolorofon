//
//  GameSounds.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import AVFoundation

final class GameSounds {

    private var audioPlayers = [AVAudioPlayer]()

    private let soundURLs = [Constants.Sounds.note1.soundFileToURL,
                             Constants.Sounds.note2.soundFileToURL,
                             Constants.Sounds.note3.soundFileToURL,
                             Constants.Sounds.note4.soundFileToURL,
                             Constants.Sounds.note5.soundFileToURL,
                             Constants.Sounds.note6.soundFileToURL]

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        createAudioPlayersForBars()
    }
}

extension GameSounds {

    func play(soundFile: Int) {
        guard soundSettingsStatus else { return }
        audioPlayers[soundFile].currentTime = 0
        audioPlayers[soundFile].play()
    }
}

private extension GameSounds {

    private func createAudioPlayersForBars() {
        soundURLs.forEach { url in
            do {
                guard let url = url else { return }
                let player = try AVAudioPlayer(contentsOf: url)
                audioPlayers.append(player)
            } catch {
                print("Error in \(#function): \(error.localizedDescription)")
            }
        }
    }

    private var soundSettingsStatus: Bool {
        return userDefaults.bool(forKey: Constants.UserDefaultsKeys.sound)
    }
}
