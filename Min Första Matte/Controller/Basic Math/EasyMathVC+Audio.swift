//
//  EasyMathVC+Audio.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-01-06.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import AVFoundation
import Foundation

extension EasyMathVC {
    
    // TODO: Gör en klass ?
    func playSound(soundName: String) {
        
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
        
        audioPlayer = AVAudioPlayer()
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
        }
        catch {
            print("No sound was heard")
        }
        audioPlayer?.play()
    }
    
}
