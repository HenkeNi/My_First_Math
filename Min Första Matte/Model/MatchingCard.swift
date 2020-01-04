//
//  MatchingCard.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-01-03.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class MatchingCard {
    
    var number: Int
    var imageName = ""
    var isFlipped = false
    var isPaired = false
    //var labelText = ""
    var indexPath: IndexPath?
    
    var getImageName: String {
         if isFlipped {
             return "Card\(number)"
         } else {
             return "CardBack"
         }
     }
    
    /*var imageName: String {
        get {
            if isFlipped {
                return "Card\(number)"
            } else {
                return "CardBack"
            }
        }
        set(newValue) {
            self.imageName = newValue
        }
    }*/
    
    
    var labelText: String {
        return number.convertIntToString()
    }
    
    
    init(number: Int) {
        self.number = number
    }
    
    
    func flipCard(cardView: UIView) {
        
        imageName = isFlipped ? "Card\(number)" : "CardBack"
        isFlipped = !isFlipped
        
        UIView.transition(with: cardView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    
    
    
    
    
}
