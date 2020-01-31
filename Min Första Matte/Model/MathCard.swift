//
//  MathCard.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

// TODO: använd conveniece initializer...
// TODO: superklass av Card -> subklasser, memoryCard, MathCard etc
// TODO: Combine Different Card Classes

// TODO: Make private variables, set and get
// TODO: set didSet listener på isFlipped och kalla på metoden för att vända kortet


// TODO: UIview property?
class MathCard {
    
    //  var cardView: UIView
    // var cardImage: UIImage
    var imageName = ""
    var isAnswerView = false // RENAME? Card that is answer/question-mark
    var position: CardPosition?
    //var originalPosition: CGPoint?
    var calcMode: CalculationMode? // Check memory leak

    
    var number = 0 {
        didSet {
            updateImageName()
            //updateLabelText()
        }
    }
    
    var isFlipped = false {
        didSet {
            updateImageName()
        }
    }

    var labelText: String {
        return number.convertIntToString()
    }
    

//    var imgName: String {
//
//    }

//    init(number: Int) {
//        self.number = number
//    }

    
    // I KLassen?
    func updateImageName() {
        switch (calcMode, isFlipped) {
        case (.addition, false), (.multiplication, false), (.none, false):
                  imageName = "Number\(number)"
        case (.subtraction, false):
                  imageName = "Number\(number)M"
        case (.addition, true), (.multiplication, true), (.none, true):
                imageName = "Number\(number)Back"
        case (.subtraction, true):
            imageName = "Number\(number)MBack"
        }
    }
    
    
    // COMBINE WITH ABOVE!?!
    var getImageName: String {
               if !isAnswerView {
                   return imageName
               } else {
                   return "NumberQuestion"
               }
    }
   

    // CLOSURE INSTEAD??
    //    var updateLabel: () -> () {
    //        self.labelText = number.converIntToString()
    //    }
        
    
//    func flipCard(cardView: UIView, duration: Double) {
//
//        UIView.transition(with: cardView, duration: duration, options: .transitionFlipFromLeft, animations: nil, completion: nil)
//        
//        isFlipped = !isFlipped
//    }
    
 
    
    
    deinit {
        print("MathCard was deallocated")
    }
    
    
}

