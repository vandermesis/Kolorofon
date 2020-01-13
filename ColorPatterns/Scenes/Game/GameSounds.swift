//
//  GameSounds.swift
//  ColorPatterns
//
//  Created by Marek Skrzelowski on 13/10/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import AVFoundation

struct GameSounds {
    
    var audioPlayer: AVAudioPlayer!
    let array = ["note1", "note2", "note3", "note4", "note5"]
    
    mutating func play(selectedFile: String) {
        guard let soundURL = Bundle.main.url(forResource: selectedFile, withExtension: "wav") else { return }
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
        } catch {
            //TODO: Handle error here
            print("Error in \(#function): \(error.localizedDescription)")
        }
        audioPlayer.play()
    }
}
