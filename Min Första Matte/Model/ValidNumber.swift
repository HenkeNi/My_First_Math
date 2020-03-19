//
//  ValidNumber.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-03-07.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

@propertyWrapper
struct ValidNumber {
    
    private var number: Int
    
    init() {
        self.number = 0
    }
    
    var wrappedValue: Int {
        get { return number }
        set {
            number = min(max(newValue, 0), 10)
//            if newValue > 10 {
//                number = 10
//            } else if newValue < 0 {
//                number = 0
//            } else {
//                number = newValue
//            }
        }
    }
}
