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
    
    init(amount: Int) {
        
        for _ in 1...amount {
            cards.append(MathCard())
        }
    }
          

    subscript(index: Int) -> MathCard {
        get {
            return cards[index]
        }
    }
    
    var answerViewIndex: Int? {
        get {
            for (index, card) in cards.enumerated() where card.isAnswerView {
                return index
            }
            return nil
        } set (newIndex) {
            cards.enumerated().forEach{ (index, card) in
                card.isAnswerView = index == newIndex ? true : false
            }
        }
    }
    
//
//    func getNumbersInEquation() -> (firstNumber: Int?, secondNumber: Int?, resultNumber: Int?) {
//        
//        switch answerViewIndex {
//
//        case 0:
//            return (nil, cards.first?.number, cards.last?.number)
//        case 1:
//            return (cards.first?.number, nil, cards.last?.number)
//        case 2:
//            return (cards.first?.number, cards.last?.number, nil)
//        default:
//            return (nil, nil, nil)
//        }
//    }
    
    deinit {
          print("MathCards will be deallocated")
      }
}



   
    
    
  
    
    
 
    
    
    
