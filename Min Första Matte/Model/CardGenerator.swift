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
class CardGenerator {
    
    // RENAME getMatchingCards??
    func getCards(amount: Int) -> [MatchingCard] {
        
        var usedNumbers = [Int]()
        var cardArray = [MatchingCard]()
        
        while usedNumbers.count < amount {
                        
            let randomNumb = Int.random(in: 0...10)
            
            if !usedNumbers.contains(randomNumb) {
                
                usedNumbers.append(randomNumb)
                
                let firstCard = MatchingCard(number: randomNumb)
                let firstCardCopy = MatchingCard(number: randomNumb)
                
                cardArray += [firstCard, firstCardCopy]
            }
        }
        cardArray.shuffle()
        return cardArray
    }
    
    
    
//    func getPlayableCards(difficulty: EasyMathVC.Difficulty) -> [MathCard] {
//
//        let cardRange: ClosedRange<Int>
//
//        switch difficulty {
//        case .easy:
//            cardRange = 1...5
//        case .medium:
//            cardRange = 6...10
//        case .hard:
//            cardRange = RandomNumberGenerator
//
//        }
//
//    }
    
    deinit {
        print("CardGenerator was deallocated")
    }
}
