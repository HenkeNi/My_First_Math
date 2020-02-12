//
//  Puzzle.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-02-11.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

class Puzzle {
    
    var pieces = [PuzzlePiece]()
    //var firstPieceTapped: Bool = false
    var firstPiece: Int?
    var secondPiece: Int?
    
    enum PuzzleSize: Int {
        case small = 9
    }
    
    
    init(puzzleSize: PuzzleSize) {
        createPieces(amount: puzzleSize.rawValue)
    }
    
    
    func createPieces(amount: Int) {
        
        for i in 1...amount {
            let imageName = "Card\(i)"
            let puzzlePiece = PuzzlePiece(imageName: imageName, indexPosition: i - 1)
            pieces.append(puzzlePiece)
        }
        
    }
    
    
   
    
}
