//
//  GameSounds.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import AVFoundation

final class GameSounds {

    private var audioPlayer1: AVAudioPlayer?
    private var audioPlayer2: AVAudioPlayer?
    private var audioPlayer3: AVAudioPlayer?
    private var audioPlayer4: AVAudioPlayer?
    private var audioPlayer5: AVAudioPlayer?
    private var audioPlayer6: AVAudioPlayer?

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        createAudioPlayersForBars()
    }
}

extension GameSounds {

    func play(soundFile: Int) {
        guard soundSettingsStatus else { return }
        switch soundFile {
        case 0:
            audioPlayer1?.currentTime = 0
            audioPlayer1?.play()
        case 1:
            audioPlayer2?.currentTime = 0
            audioPlayer2?.play()
        case 2:
            audioPlayer3?.currentTime = 0
            audioPlayer3?.play()
        case 3:
            audioPlayer4?.currentTime = 0
            audioPlayer4?.play()
        case 4:
            audioPlayer5?.currentTime = 0
            audioPlayer5?.play()
        case 5:
            audioPlayer6?.currentTime = 0
            audioPlayer6?.play()
        default:
            audioPlayer6?.currentTime = 0
            audioPlayer6?.play()
        }
    }
}

private extension GameSounds {

    private func createAudioPlayersForBars() {
        guard let sound1URL = Bundle.main.url(forResource: Constants.Sounds.note1,
                                              withExtension: Constants.Sounds.audioFormat) else { return }
        guard let sound2URL = Bundle.main.url(forResource: Constants.Sounds.note2,
                                              withExtension: Constants.Sounds.audioFormat) else { return }
        guard let sound3URL = Bundle.main.url(forResource: Constants.Sounds.note3,
                                              withExtension: Constants.Sounds.audioFormat) else { return }
        guard let sound4URL = Bundle.main.url(forResource: Constants.Sounds.note4,
                                              withExtension: Constants.Sounds.audioFormat) else { return }
        guard let sound5URL = Bundle.main.url(forResource: Constants.Sounds.note5,
                                              withExtension: Constants.Sounds.audioFormat) else { return }
        guard let sound6URL = Bundle.main.url(forResource: Constants.Sounds.note6,
                                              withExtension: Constants.Sounds.audioFormat) else { return }

        do {
            try audioPlayer1 = AVAudioPlayer(contentsOf: sound1URL)
            try audioPlayer2 = AVAudioPlayer(contentsOf: sound2URL)
            try audioPlayer3 = AVAudioPlayer(contentsOf: sound3URL)
            try audioPlayer4 = AVAudioPlayer(contentsOf: sound4URL)
            try audioPlayer5 = AVAudioPlayer(contentsOf: sound5URL)
            try audioPlayer6 = AVAudioPlayer(contentsOf: sound6URL)
        } catch {
            print("Error in \(#function): \(error.localizedDescription)")
        }
    }

    private var soundSettingsStatus: Bool {
        return userDefaults.bool(forKey: Constants.UserDefaultsKeys.sound)
    }
}
