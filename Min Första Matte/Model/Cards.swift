//
//  Cards.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-03-21.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

// Use a protocol with associated type???
// TODO: rename CardList? || CardStack
class Cards<T: Card> {
    
    var cards = [T]()
   
//    init(amount: Int) {
//        for _ in 1...amount {
//            //let card = T()
//
//            addCard(card: T())
//            //cards.append(card)
//        }
//    }
    
    subscript(index: Int) -> T? {
        get {
            return index >= cards.count ? nil : cards[index]
        }
        set {
            guard let newNumber = newValue?.number else { return }
            cards[index].number = newNumber
        }
    }

    func addCard(card: T) {
        cards.append(card)
    }
    
    deinit {
        print("Cards will be deallocated")
    }
    
    
}

extension Cards where T: EquationCard {

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
