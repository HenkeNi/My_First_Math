//
//  PuzzleGameVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-10-03.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class PuzzleGameVC: UIViewController {

    // property isInCorretPlace?
    // array för correctPlace [1, 2, 3, etc] (varje puzzel bit har ett nummer?)
    
    // Lätt: Klicka på en ruta; sedan en annan för att byta plats på dem..
    
    // Medel/Svår: En ruta "saknas", måste glida dem längs banan för att ändra dem...
    
    // Klicka på en rutan sen en annan för att byta plats på dem??
    
    
    // Antingen att man pusslar ihop en stor siffra (tex: varje ruta utgör olika delar av nummer ett) eller varje ruta är en siffra/kort som sedan ska rangordnas i storleksordning
    
    // Eller göra ett till pussel för stora siffror (där man drar bitar till plats)
    
    // Gör en puzzelPieces klass och lägg firstCardIndex i? (Kunna ange hur många bittar att skapa)
    
    // TODO: RUTA RUNT VALDA BITEN?!
    
    @IBOutlet weak var puzzleCollectionView: UICollectionView!
    
    
    
    //var images = ["Card1", "Card2", "Card3", "Card4", "Card5", "Card6", "Card7", "Card8", "Card9"]
    // Array av images för number 1
    //let imagesNumb1 = [""]()
    
    //var firstCardIndex = 10
    
    var puzzlePieces: Puzzle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Disabel interaction
        setCellSize()
        
        puzzlePieces = Puzzle(puzzleSize: .small)
            
        
    }
  
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            
            self.shufflePieces()
            // TODO: ENABLE TOUCH
            //self.setPuzzlePiecesPosition()
            //self.shufflePuzzlePieces()
        }
    }

    
    func setPuzzlePiecePosition(position: Int, puzzlePiece: PuzzlePiece) {
        puzzlePiece.currentPosition = position
    }
    
    func setPuzzlePiecesPosition(position: Int) {
        guard let puzzlePieces = puzzlePieces?.pieces else { return }
        for piece in puzzlePieces {
            piece.currentPosition = position
        }
    }

    func shufflePieces() {
        puzzlePieces?.pieces.shuffle()
        puzzleCollectionView.reloadData()
    }
    
    func checkForCompletion() {
           
        
        
        guard let puzzlePieces = puzzlePieces?.pieces else { return }
        
        for puzzlePiece in puzzlePieces {
            
            print("\(puzzlePiece.currentPosition!) current")
            print("\(puzzlePiece.indexPosition) index")
            
//            if puzzlePiece.currentPosition! != puzzlePiece.indexPosition {
//                return
//            }
//            print("VICTORY")
            
        }
           
    }

}

//  func shufflePuzzlePieces() {
//        images.shuffle()
//        puzzleCollectionView.reloadData()
//    }

//    func shuffleCardsWithAnimation() {
//
//        UIView.animateKeyframes(withDuration: 3, delay: 0, options: .calculationModeLinear, animations: {
//
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
//                self.images.shuffle()
//                self.puzzleCollectionView.reloadData()
//            }
//            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 1.0) {
//                self.images.shuffle()
//                self.puzzleCollectionView.reloadData()
//            }
//            UIView.addKeyframe(withRelativeStartTime: 2.0, relativeDuration: 1.0) {
//                self.images.shuffle()
//                self.puzzleCollectionView.reloadData()
//            }
//
//        }) { (true) in
//
//            if true {
//                self.enableInteraction() } // TODO: enable interaction
//            }
//    }
    
