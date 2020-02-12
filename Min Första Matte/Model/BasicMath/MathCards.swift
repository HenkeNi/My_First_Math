//
//  MathCards.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-01-30.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

class MathCards {
    
    var cards = [MathCard]()
    var answerViewIndex: Int?
    
    init(amountOfCards: Int) {
        addCards(amountOfCards: amountOfCards)
    }
    
    subscript(index: Int) -> MathCard {
        get {
            return cards[index]
        }
    }
    
    
//    let createCards = { (amount: Int) in
//
//        for _ in 1...amount {
//            cards.append(MathCard())
//        }
//    }
//
//
//    let createCards2 = { () -> MathCard in
//        let card = MathCard()
//        return card
//    }
    
     func addCards(amountOfCards: Int) {
         
         for _ in 1...amountOfCards {
//            var card: MathCard? = MathCard()
//            cards.append(card)
             cards.append(MathCard())
         }
     }
     
   
    
    func setAnswerViewIndex(answerViewIndex: Int) {
        for (index, card) in cards.enumerated() {
            card.isAnswerView = index == answerViewIndex ? true : false
        }
    }
     
    
     
  
    
    
//    var answerViewIndex: Int? {
//          get {
//              for (index, card) in cards.enumerated() where card!.isAnswerView {
//                  return index
//              }
//              return nil
//          }
//          set(newIndexPosition) {
//              for (index,card) in cards.enumerated() {
//                  if index == newIndexPosition {
//                      card?.isAnswerView
//                  }
//              }
//          }
//      }
    
    
    deinit {
         //for card in cards { card = nil }
          print("MathCards will be deallocated")
      }
}



   
    
    
  
    
    
 
    
    
    
