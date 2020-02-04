//
//  Card.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

// FLip card eget protocol?
// pairable protocol med?
protocol Card {
    
    //var frontImgName: String { get set}
    //var backImgName: String { get set }
    var imageName: String { get set }
    var number: Int { get set }
    var isFlipped: Bool { get set }
    var labelText: String { get set }
}

extension Card {
    
    // UNDVIK IMPORTERA UIKIT!!
//    mutating func flipCard(card: UIView) {
//
//        imageName = isFlipped ? imageName : imageName + "Back"
//
//        isFlipped = !isFlipped
//
//        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
//    }
    
//    func flipCardBack(card: UIView, fromImage: String, toImage: String) {
//
//
//
//    }
}
