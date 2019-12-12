//
//  CardDeck.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-10-02.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

class CardDeck {
    
    var deckOfCards = [GameCard]()
    
    init() {
        createCardDeck()
    }
    
    // Make private
    func createCardDeck() {
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                let newCard = GameCard(rank: rank, suit: suit)
                deckOfCards.append(newCard)
            }
        }
        deckOfCards.shuffle()
    }
    
    func showCardDeck() {
        for card in deckOfCards {
            print("\(card.rank) of \(card.suit)")
        }
    }
    
    func drawCard() -> GameCard {
        let drawnCard = deckOfCards.remove(at: 0)
        return drawnCard
    }
}
