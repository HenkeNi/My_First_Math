//
//  EasyMathVC+panGest.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-27.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

// rename +UserInteractions, GestRec, Gestures
extension EasyMathVC {
    
  
    @objc func didTapView(sender: UITapGestureRecognizer) {

        print("TAPPING")
        guard let cardView = sender.view else { return }
        
        SoundManager.shared.playSound(soundName: "Woosh")
        cardView.flipView(duration: 0.3)
        
        if playableCardViews.contains(cardView) {
            updateFlippedCard(cards: playableCards?.cards, index: cardView.tag - 1, cardImages: playableCardImages)
        }
        if equationCardViews.contains(cardView) {
            updateFlippedCard(cards: equationCards?.cards, index: cardView.tag - 1, cardImages: equationCardImages)
        }
    }
    
    func updateFlippedCard(cards: [MathCard]?, index: Int, cardImages: [UIImageView]) {
        
        guard let cards = cards else { return }
        cards[index].isFlipped.toggle()
        setCardImages(cards: cards, cardImages: cardImages)
        
    }
    

    
    
    
    
    // Function for moving (card) view
    func moveView(currentView: UIView, sender: UIPanGestureRecognizer) {
             
        let translation = sender.translation(in: view)

        currentView.center = CGPoint(x: currentView.center.x + translation.x, y: currentView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
             
        view.bringSubviewToFront(currentView)
    }
    
    
    // Handles different gesture recognizer states
    @IBAction func handlePan(sender: UIPanGestureRecognizer) {
        
        guard let handledCard = sender.view else { return }
        
        switch sender.state {
            
        case .began, .changed:
            moveView(currentView: handledCard, sender: sender)
        case .ended:
            if let index = equationCards?.answerViewIndex, handledCard.frame.intersects(equationCardViews[index].frame) {
                validateChosenAnswer(currentView: handledCard, answerView: equationCardViews[index])
            } else {
                print("HERE?!?!?!")
                returnCard(cardView: handledCard)
                //returnCards()
            }
        default:
            break
        }
    }
    
    
    
    
    @objc func tappedMuteBtn() {
        
        MusicPlayer.shared.isPlaying ? MusicPlayer.shared.stopBackgroundMusic() : MusicPlayer.shared.resumeBackgroundMusic()
        //MusicPlayer.shared.stopBackgroundMusic()
    }
}


