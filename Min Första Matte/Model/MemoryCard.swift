//
//  MemoryCard.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-11.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

// REMOVE
// TODO: Make a superClass called Card the subclasses like GameCard etc.??
// TODO: Combine with Card class
class MemoryCard {
    
    var imageName = ""
    var isFlipped = false
    var isPaired = false
    var imageNumber = 0
    
    
    
    func findCards() -> [MemoryCard] {
        
        var randomNumbArray = [Int]()
        var cardDeckArray = [MemoryCard]()
        
        // For deck with 8 (pairs of) Cards
        while randomNumbArray.count < 8 {
            
            let randomNumb = Int.random(in: 0...8)
            
            // If the randomNumber is not already in the array
            if !randomNumbArray.contains(randomNumb) {
                
                // Append random (unique) number to array
                randomNumbArray.append(randomNumb)
                
                // Append random number to first Card
                let firstCard = MemoryCard()
                firstCard.imageName = "Card\(randomNumb)"
                cardDeckArray.append(firstCard)
                
                // Append second Card
                let secondCard = MemoryCard()
                secondCard.imageName = "Card\(randomNumb)"
                cardDeckArray.append(secondCard)
            }
        }
        
        for i in 0..<cardDeckArray.count {
            
            let randomPosition = Int.random(in: 0..<cardDeckArray.count)
            
            let tempStorage = cardDeckArray[i]
            cardDeckArray[i] = cardDeckArray[randomPosition]
            cardDeckArray[randomPosition] = tempStorage
        }
        return cardDeckArray
    }
    
    
    func turnCard(cardView: UIView) {
        
        imageName = isFlipped ? "Card\(imageNumber)" : "CardBack"
        isFlipped = !isFlipped
        
        UIView.transition(with: cardView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
    }
    
    
    func removeCard() {
        
        // TEST
              // UIView.transition(with: cardView, duration: 0.6, options: .transitionFlipFromLeft, animations: nil, completion: nil)
               //imageName = "Number\(number)"
    }
    
    
 
    
    
}
