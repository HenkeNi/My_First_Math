//
//  Card.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-07.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

// TODO: superklass av Card -> subklasser, memoryCard, MathCard etc
// TODO: UIview property?
// TODO: Combine Different Card Classes
// TODO: Make private variables, set and get
class Card {
        
    var imageName = ""
    var number = 0
    var numberText = ""
    var isFlipped = false
    var isPaired = false
    var originalPosition: CGPoint?
    
    //var containerView : UIView
    
//    init(containerView: UIView) {
//        self.containerView = containerView
//    }

    
    
    // Return a UIIMage name/string?
    func turnCard(cardView: UIView, mode: CalculationMode) {
        
        switch mode {
        case .addition:
            imageName = isFlipped ? "Number\(number)" : "Number\(number)Back"
        case .subtraction:
            imageName = isFlipped ? "Number\(number)M" : "Number\(number)MBack"
        }
        isFlipped = !isFlipped

            UIView.transition(with: cardView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
    }
    
    // Turn card back to front side
    func flipCardBack(cardView: UIView) {
        isFlipped = false
        
        // TEST
        UIView.transition(with: cardView, duration: 0.6, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        //imageName = "Number\(number)"
    }
    
    
    func updateImageName(mathMode: CalculationMode) {
        
        imageName = mathMode == .addition ? "Number\(number)" : "Number\(number)M"
        
        //imageName = "Number\(number)"
    }
    
    func updateNumberText() {
        numberText = number.convertIntToString()
    }

    
    
    
    
}
