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
    
    static let shared = SoundManager()
    var audioPlayer: AVAudioPlayer?
    
    func startBackgroundMusic() {
            
        if let bundle = Bundle.main.path(forResource: "Click", ofType: "wav") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    
    //var audioPlayer: AVAudioPlayer
  
//    init() {
//        self.audioPlayer = AVAudioPlayer()
//    }
    
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
        audioPlayer?.play()
    }
    
}
