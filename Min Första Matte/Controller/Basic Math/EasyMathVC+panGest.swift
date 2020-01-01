//
//  EasyMathVC+panGest.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-27.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

extension EasyMathVC {
    
    
    
    // Adds UITapGestureRecognizer to all card images
    func addImageTapGesture() {
        
        for cardImage in cardImages {
            
            cardImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCardOnTap(gesture:))))
        }
    }
    

    // RENAME: touchedCard??
    // Flips the card on cardImage tap
    @objc func flipCardOnTap(gesture: UITapGestureRecognizer) {
        
        soundEffects(soundName: "Woosh")
        
        // For every cardView that has the same tag number as the cardImage's tag
        for (index, cardView) in cardViews.enumerated() where gesture.view?.tag == cardView.tag {
            
            if gesture.view as? UIImageView != nil {

                if cardView.tag <= 5 {
                    cards[index].flipCard(cardView: cardView, mode: mathMode)
                } else { // TODO: Improve/ make better
                    topCards[cardView.tag - 6].flipCard(cardView: cardView, mode: mathMode)
                }
            }
            updateCardImages()
        }
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
            WrongImage.isHidden = true
            
        case .ended:
            if handledCard.frame.intersects(getAnswerView()!.frame) {
                soundEffects(soundName: "Click")
                validateChosenAnswer(currentView: handledCard, answerView: getAnswerView()!)
            } else {
                returnCardsToPositions()
            }
        default:
            break
        }
    }
    
    
}
