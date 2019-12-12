//
//  GameCard.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-10-02.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

// TODO: ADD BONUS CARDS, vänder ut, lägg vad du vill
   enum Suit: CaseIterable {
       case Hearts
       case Diamonds
       case Spades
       case Clubs
   }

   enum Rank: Int, CaseIterable {
       case Zero = 0
       case One
       case Two
       case Three
       case Four
       case Five
       case Six
       case Seven
       case Eight
       case Nine
       case Ten
   }

class GameCard {
    
    var rank: Rank
    var suit: Suit
    
    init(rank: Rank, suit: Suit) {
        self.rank = rank
        self.suit = suit
    }
}
