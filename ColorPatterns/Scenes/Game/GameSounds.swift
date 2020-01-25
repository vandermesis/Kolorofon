//
//  GameSounds.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import AVFoundation

final class GameSounds {

    private var soundFile: Int = 0
    private var url: URL? {
        let soundURL = Bundle.main.url(forResource: soundsArray[soundFile],
                                       withExtension: Constants.Sounds.wavFormat)
        return soundURL
    }
    //FIXME: That doesn't work properly.
    // Only some sounds are played because only one player is created and it has to play sound to the end
    private lazy var audioPlayer: AVAudioPlayer = {
        [unowned self] in
        do {
            guard let url = url else { return AVAudioPlayer.init() }
            return try AVAudioPlayer.init(contentsOf: url)
        } catch {
            return AVAudioPlayer.init()
        }
    }()

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
        self.soundFile = soundFile
        audioPlayer.play()
    }
}

private extension GameSounds {

    private var soundSettingsStatus: Bool {
        return userDefaults.bool(forKey: Constants.UserDefaultsKeys.sound)
    }
}
