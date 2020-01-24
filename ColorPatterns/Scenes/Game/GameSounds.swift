//
//  GameSounds.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import AVFoundation

struct GameSounds {
    
    private var audioPlayer: AVAudioPlayer?

    private let soundsArray = [Constants.Sounds.note1, Constants.Sounds.note2, Constants.Sounds.note3, Constants.Sounds.note4, Constants.Sounds.note5]
    
    mutating func play(soundFile: Int) {
        guard let soundURL = Bundle.main.url(forResource: soundsArray[soundFile],
                                             withExtension: Constants.Sounds.wavFormat) else { return }
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
            // TODO: You're creating new audio player for each sound? why?
            // try lazy initialization
        } catch {
            print("Error in \(#function): \(error.developerFriendlyMessage)")
        }
        audioPlayer?.play()
    }
}
