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
    
    @objc func imgTapPlayableCard(sender: UITapGestureRecognizer) {
        
        playSound(soundName: "Woosh")
                        
        //For every cardView that has the same tag number as the cardImage's tag
        for (index, view) in playableCardViews.enumerated() where sender.view?.tag == view.tag {
            
            if sender.view as? UIImageView != nil {
                playableCards[index].flipCard(cardView: view, duration: 0.3)
            }
            setCardImages(cards: playableCards, cardImages: playableCardImages)
        }
    }
    
    
    @objc func imgTapEquationCard(sender: UITapGestureRecognizer) {

        playSound(soundName: "Woosh")
        
        for (index, view) in equationCardViews.enumerated() where sender.view?.tag == view.tag {
                        
            if sender.view as? UIImageView != nil {
                equationCards[index].flipCard(cardView: view, duration: 0.3)
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
            
            moveView(currentView: handledCard, sender: sender)
            //changeAnswerViewImage(displayWrongAnswer: false) //WrongImage.isHidden = true
        case .ended:
            if handledCard.frame.intersects(equationCardViews[getAnswerViewIndex()].frame) {
            //if handledCard.frame.intersects(getAnswerView()!.frame) {
                playSound(soundName: "Click")
                validateChosenAnswer(currentView: handledCard, answerView: equationCardViews[getAnswerViewIndex()])
                //validateChosenAnswer(currentView: handledCard, answerView: getAnswerView()!)
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
