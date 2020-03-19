//
//  MatchingCard.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-01-03.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

//TODO: GÖR Equatable!?!?!?!
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
        return number.spellOutNumber()
    }
    
    
    init(number: Int) {
        self.number = number
    }
    
    
    func flipCard(cardView: UIView) {
        
        imageName = isFlipped ? "Card\(number)" : "CardBack"
        isFlipped = !isFlipped
        
        UIView.transition(with: cardView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    
    
    /*static func getCards(amount: Int) -> [MatchingCard] {
         
         var usedNumbers = [Int]()
         var cardArray = [MatchingCard]()
         
         while usedNumbers.count < amount {
             
             //let randomNumb = Int.random(in: 0...10)
             let randomNumb = 3
             
             if !usedNumbers.contains(randomNumb) {
                 
                 usedNumbers.append(randomNumb)
                 
                 let firstCard = MatchingCard(number: randomNumb)
                 //firstCard.number = randomNumb
                 //firstCard.imageName = "Card\(randomNumb)"
                 //firstCard.labelText = randomNumb.convertIntToString()
                 let secondCard = MatchingCard(number: randomNumb)
                 //secondCard.number = randomNumb
                 //secondCard.imageName = "Card\(randomNumb)"
                 cardArray.append(firstCard)
                 cardArray.append(secondCard)
             }
         }
         
         cardArray.shuffle()
         
         return cardArray
     }*/
    
    
    
}
