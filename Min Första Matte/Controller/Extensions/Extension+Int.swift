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
    func spellOutNumber() -> String {
        
        return NumberFormatter.localizedString(from: self as NSNumber, number: .spellOut).firstLetterUppercased
    }
    
    
}
