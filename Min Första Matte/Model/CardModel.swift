//
//  CardModel.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation
import UIKit // REMOVE??
// RENAME Card?
protocol CardModel {
    
    var imageName: String { get set }
    var cardNumber: Int { get set }
    var isFlipped: Bool { get set }
    var labelText: String { get set }
}

extension CardModel {
    
    func flipCard(card: UIView, fromImage: String, toImage: String) {
        
    }
    
    func flipCardBack(card: UIView, fromImage: String, toImage: String) {
        
    }
}
