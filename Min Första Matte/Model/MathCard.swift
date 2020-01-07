//
//  MathCard.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

// TODO: ANVÄND STRUCT ISTÄLLET FÖR CLASS????

// TODO: superklass av Card -> subklasser, memoryCard, MathCard etc
// TODO: UIview property?
// TODO: Combine Different Card Classes
// TODO: Make private variables, set and get
class MathCard {
    
    var labelText: String = "" // FIX
    var imageName: String = "" // FIX
    var isFlipped = false
    var isAnswerView = false
    var originalPosition: CGPoint?

    
    // FIX
    var number: Int = 0 {
        didSet {
            updateImageName(mathMode: .addition) // Fixa för minus .etc...
            updateLabelText()
        }
    }
    
    
    var getImageName: String {
        if !isAnswerView {
            return imageName
        } else {
            return "NumberQuestion"
        }
    }
    
    

    


    
    
    
    /*init(number: Int, imageName: String, labelText: String) {
        self.number = number
        self.imageName = imageName
        self.labelText = labelText
    }*/
    
    
    var mathCardImageName: String {
        if isFlipped {
            return "Card\(number)"
        } else {
            return "CardBack"
        }
    }
    
    //var containerView : UIView
    
//    init(containerView: UIView) {
//        self.containerView = containerView
//    }

    
    
    
    // TODO: set didSet listener på isFlipped och kalla på metoden för att vända kortet
    
    
    
    // Return a UIIMage name/string?
    /*func turnCard(cardView: UIView, mode: CalculationMode) {
        
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
    }*/
    
    
    // Return a UIIMage name/string?
    func flipCard(cardView: UIView, mode: CalculationMode) {
        
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
        imageName = "Number\(number)"
    }
    
    func updateImageName(mathMode: CalculationMode) {

        var imgName: String
        
        switch mathMode {
        case .addition:
            imgName = "Number\(number)"
        case .subtraction:
            imgName = "Number\(number)M"
            // TOOD: add multi / div
        }
        
        imageName = imgName
        
        
            
        //imageName = mathMode == .addition ? "Number\(number)" : "Number\(number)M"
        
        //imageName = "Number\(number)"
    }
    
    
    
    func updateLabelText() {
        labelText = number.convertIntToString()
    }

    
    
    
    
}


/*
 
 class MathCard: Card {
     
     
     var labelText: String
     
     var imageName = ""
     var number = 0
     var numberText = ""
     var isFlipped = false
     var isPaired = false
     var originalPosition: CGPoint?
     
  
     
     var matchingCardImageName: String {
         if isFlipped {
             return "Card\(number)"
         } else {
             return "CardBack"
         }
     }
     
     //var containerView : UIView
     
 //    init(containerView: UIView) {
 //        self.containerView = containerView
 //    }

     
     
     
     // TODO: set didSet listener på isFlipped och kalla på metoden för att vända kortet
     
     
     
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

 */
