//
//  CardGenerator.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

// COmbine with numberRandomizer?
class CardGenerator {
    
    
   
    func getCards(amount: Int) -> [MathCard] {
        
        var usedNumbers = [Int]()
        var cardArray = [MathCard]()
        
        while usedNumbers.count < amount {
            
            let randomNumb = Int.random(in: 0...10)
            
            if !usedNumbers.contains(randomNumb) {
                
                usedNumbers.append(randomNumb)
                
                let firstCard = MathCard()
                firstCard.number = randomNumb
                firstCard.imageName = "Card\(randomNumb)"
                firstCard.labelText = randomNumb.convertIntToString()
                cardArray += [firstCard, firstCard]
            }
        }
        
        cardArray.shuffle()
        
        return cardArray
    }
    
    
    
    
    
    
    /*func findCards(cardAmount: Int) -> [Card] {
        
        var cardArray = [Card]()
        
        for i in 0...10 {
            let card = Card()
            card.number = i
            cardArray.append(card)
        }
        
        
        
        
        
        while cardArray.count < (cardAmount * 2) {
            
            
            let randomNumber = Int.random(in: 0...10)
            
        }
        
        
        
        for i in 1...cardAmount {
            
            let card = Card()
            card.number = i
            cardArray += [card, card]
            
        }
        
        return cardArray
    }*/
    
 
    
}
