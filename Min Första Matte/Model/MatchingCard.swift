//
//  MatchingCard.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-01-03.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

//TODO: GÖR Equatable!?!?!?!
class MatchingCard: Card {
    
    var number: Int
    var isFlipped = false
    var isPaired = false
    var indexPath: IndexPath?
    
    var imageName: String {
        return isFlipped ? "Card\(number)" : "CardBack"
    }

    var labelText: String {
        return number.spellOutNumber()
    }
    
    init(number: Int) {
        self.number = number
    }
    
    
}
