//
//  CardGenerator.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

// COmbine with numberRandomizer?
// STRUCT istället?
struct CardGenerator {
    
    func getCards(amount: Int) -> [MatchingCard] {
        
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
    }
    
}


/*class CardGenerator {
    
    
   
    func getCards(amount: Int) -> [MatchingCard] {
        
        var usedNumbers = [Int]()
        var cardArray = [MatchingCard]()
        
        while usedNumbers.count < amount {
            
            let randomNumb = Int.random(in: 0...10)
            
            if !usedNumbers.contains(randomNumb) {
                
                usedNumbers.append(randomNumb)
                
                let firstCard = MatchingCard()
                firstCard.number = randomNumb
                firstCard.imageName = "Card\(randomNumb)"
                firstCard.labelText = randomNumb.convertIntToString()
                let secondCard = MatchingCard()
                secondCard.number = randomNumb
                secondCard.imageName = "Card\(randomNumb)"
                cardArray.append(firstCard)
                cardArray.append(secondCard)
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
*/
