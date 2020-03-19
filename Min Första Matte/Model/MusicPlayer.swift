//
//  MusicPlayer.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-03-09.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation
import AVFoundation

class MusicPlayer {
    
    
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    
    func startBackgroundMusic(forResource songName: String, songFormat format: String) {
            
        if let bundle = Bundle.main.path(forResource: songName, ofType: format) {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                isPlaying = true
            } catch {
                print(error)
            }
        }
    }
    
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
        isPlaying = false
    }
    
    
    func resumeBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.play()
        isPlaying = true
    }

    
    func playSoundEffect(soundEffect: String, songFormat format: String) {
        if let bundle = Bundle.main.path(forResource: soundEffect, ofType: format) {
            let soundEffectUrl = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundEffectUrl as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.play()
            } catch {
                print(error)
            }
            
        }
    }
    
}
