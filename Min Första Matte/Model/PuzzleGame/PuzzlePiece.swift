//
//  PuzzlePiece.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-02-11.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

class PuzzlePiece {
    
    var imageName = ""
    var isSelected = false
    var indexPosition: Int
    var currentPosition: Int?
    
    init(imageName: String, indexPosition: Int) {
        self.imageName = imageName
        self.indexPosition = indexPosition
    }
    
    
    /*func isOnTheCorrectPlace() -> Bool {
        
    }*/
    
}
