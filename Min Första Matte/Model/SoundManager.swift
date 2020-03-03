//
//  SoundManager.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-02-25.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    var audioPlayer: AVAudioPlayer
  
    init() {
        self.audioPlayer = AVAudioPlayer()
    }
    
    func playSound(soundName: String) {
        
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
        print("HELE")
        print(soundURL)
        //var audioPlayer: AVAudioPlayer? = AVAudioPlayer()
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print("No sound was heard")
        }
        audioPlayer.play()
    }
    
}
