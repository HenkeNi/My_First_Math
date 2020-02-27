//
//  MathCard.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

class MathCard: Card {

    var position: CardPosition?
    var number: Int
    var isFlipped = false
    var isAnswerView = false

    var labelText: String {
        return number.spellOutNumber()
    }
       
    var imageName: String {
        let imgName = isFlipped ? "Number\(number)Back" : "Number\(number)"
        return !isAnswerView ? imgName : "NumberQuestion"
    }
    
    init(number: Int = 0) {
        self.number = number
    }
    
    
    deinit {
        print("MathCard will be deallocated")
    }
    
    
}

