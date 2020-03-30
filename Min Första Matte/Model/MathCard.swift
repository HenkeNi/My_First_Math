//
//  MathCard.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

class MathCard: Card {

    @ValidNumber var number: Int
    var position: CardPosition? // TODO: LÄGG I CARDVIEW ISTÄLLET
    var isFlipped = false
       
    var imageName: String {
        return isFlipped ? "Number\(number)Back" : "Number\(number)"
    }
    
    init(number: Int = 0) {
        self.number = number
    }
    
}

