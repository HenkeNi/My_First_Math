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
    

    
    func soundEffects(soundName: String) {
        
        let soundURL = Bundle.main.url(forResource: soundName, withExtension: "wav")
        
        audioPlayer = AVAudioPlayer()
        
        audioPlayer = try! AVAudioPlayer(contentsOf: soundURL!)
        audioPlayer!.play()
        
        /*if var audioPlayer = audioPlayer {
         
         audioPlayer = try! AVAudioPlayer(contentsOf: soundURL!)
         audioPlayer.play()
         }*/
    }
    
}
