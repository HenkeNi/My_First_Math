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
    
    
    // Adds UITapGestureRecognizer to all card images
    func addImgTapGesture(cardImages: [UIImageView], isPlayableCardImage: Bool) {
                
        for cardImage in cardImages {
            
            isPlayableCardImage ? cardImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imgTapPlayableCard(sender:)))) : cardImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imgTapEquationCard(sender:))))
        }
    }
    
    // TODO: Lägg i en extension av UITapGestureRecognizer???
    @objc func imgTapPlayableCard(sender: UITapGestureRecognizer) {
        
        guard let playableCards = playableCards?.cards else { return }
        
        playSound(soundName: "Woosh")
                        
        //For every cardView that has the same tag number as the cardImage's tag        
        for (index, view) in playableCardViews.enumerated() where sender.view?.tag == view.tag {
            
            if sender.view as? UIImageView != nil {
                
                view.flipView(duration: 0.3)
                
                playableCards[index].isFlipped.toggle()
            }
            setCardImages(cards: playableCards, cardImages: playableCardImages)
        }
    }
    
    
    @objc func imgTapEquationCard(sender: UITapGestureRecognizer) {

        guard let equationCards = equationCards?.cards else { return }
        
        playSound(soundName: "Woosh")
        
        for (index, view) in equationCardViews.enumerated() where sender.view?.tag == view.tag {
                        
            if sender.view as? UIImageView != nil {
                //equationCards[index].flipCard(cardView: view, duration: 0.3)
                view.flipView(duration: 0.3)
                equationCards[index].isFlipped.toggle()
            }
            setCardImages(cards: equationCards, cardImages: equationCardImages)
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
            changeAnswerViewImage(displayWrongAnswer: false)
            moveView(currentView: handledCard, sender: sender)
        case .ended:
            if let index = equationCards?.answerViewIndex, handledCard.frame.intersects(equationCardViews[index].frame) {
                validateChosenAnswer(currentView: handledCard, answerView: equationCardViews[index])
            } else {
                returnCardViewsToOriginalPosition()
            }
        default:
            break
        }
    }
    
    
}






//    func addImageTapGesture() {
//
//        for cardImage in cardImages {
//
//            cardImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCardOnTap(gesture:))))
//        }
//    }
//
//
//     //Flips the card on cardImage tap
//    @objc func flipCardOnTap(gesture: UITapGestureRecognizer) {
//
//        soundEffects(soundName: "Woosh")
//
//        //For every cardView that has the same tag number as the cardImage's tag
//        for (index, cardView) in cardViews.enumerated() where gesture.view?.tag == cardView.tag {
//
//            if gesture.view as? UIImageView != nil {
//
//                if cardView.tag <= 5 {
//                    playableCards[index].flipCard(cardView: cardView, mode: mathMode)
//                } else {  TODO: Improve/ make better
//                    equationCards[cardView.tag - 6].flipCard(cardView: cardView, mode: mathMode)
//                }
//            }
//            updateCardImages()
//        }
//    }


