//
//  Extension+Int.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-14.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

extension Int {
    
    // Converts number to string
    func convertIntToString() -> String {
        
        switch self {
        case 1:
            return "One"
        case 2:
            return "Two"
        case 3:
            return "Three"
        case 4:
            return "Four"
        case 5:
            return "Five"
        default:
            return ""
        }
    }
    
    
}
