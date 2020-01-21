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

    private let soundsArray = [K.Sounds.note1, K.Sounds.note2, K.Sounds.note3, K.Sounds.note4, K.Sounds.note5]
    
    mutating func play(soundFile: Int) {
        guard let soundURL = Bundle.main.url(forResource: soundsArray[soundFile],
                                             withExtension: K.Sounds.wavFormat) else { return }
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
        } catch {
            //TODO: Handle error here
            print("Error in \(#function): \(error.localizedDescription)")
        }
        audioPlayer?.play()
    }
}
