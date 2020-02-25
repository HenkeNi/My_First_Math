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
    
    
  
    
    static func playSound(soundName: String) {
                
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
        
        var audioPlayer = AVAudioPlayer()
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
            audioPlayer.play()
        } catch {
            print("No sound was heard")
        }
    }
    
}
