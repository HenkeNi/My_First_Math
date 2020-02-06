//
//  cardPosition.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-01-30.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

class CardPosition {
    
    var xPosition: Double
    var yPosition: Double
    
    init(xPosition: Double, yPosition: Double) {
        self.xPosition = xPosition
        self.yPosition = yPosition
    }
    
    deinit {
        print("CardPosition will be deallocated")
    }
    
}
