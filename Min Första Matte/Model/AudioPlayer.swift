//
//  AudioPlayer.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-02-19.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//


// KORKAD IDE??? KNASKE GÖR SUBKLASS ISTÄLLET??
import Foundation
import AVFoundation

class AudioPlayer: AVAudioPlayer {

    func playSound(soundName: String) {

        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
        
        var audioPlayer = AVAudioPlayer()
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
            //try AudioPlayer(contentsOf: soundURL)
        } catch {
            print("No sound was heard")
        }
        
        audioPlayer.play()
        
    }

}
