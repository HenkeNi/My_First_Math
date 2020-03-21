//
//  Cards.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-03-21.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

// TODO: rename CardList? || CardStack
class Cards<T: Card> {
    
    var cards = [T]()
   
    // TODO: Set cardnumber here?
    subscript(index: Int) -> T? {
        return index >= cards.count ? nil : cards[index]
    }

    func addCard(card: T) {
        cards.append(card)
    }
    
    
    
    deinit {
        print("Cards will be deallocated")
    }
    
    
}

// TODO: where T: EquaitonCard ??!??!
extension Cards where T: EquationCard {
//extension Cards where T: MathCard {
    
    var answerViewIndex: Int? {
        get {
            for (index, card) in cards.enumerated() where card.isAnswerView {
                return index
            }
            return nil
        }
        set {
            cards.enumerated().forEach{ (index, card) in
                card.isAnswerView = index == newValue ? true : false
            }
        }
    }
    
}
