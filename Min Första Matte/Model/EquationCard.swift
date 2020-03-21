//
//  EquationCard.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-03-21.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

class EquationCard: Equation {
    
    @ValidNumber var number: Int
    var isFlipped: Bool = false
    var isAnswerView: Bool = false

    
    var imageName: String {
           let imgName = isFlipped ? "Number\(number)Back" : "Number\(number)"
           return !isAnswerView ? imgName : "NumberQuestion"
       }
    
    init(number: Int = 0) {
        self.number = number
    }
    
    
}
