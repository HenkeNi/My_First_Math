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
    @IBOutlet weak var puzzleCollectionView: UICollectionView!
    
    let images = ["Card1", "Card2", "Card3", "Card4", "Card5", "Card6", "Card7", "Card8", "Card9"]
    // Array av images för number 1
    //let imagesNumb1 = [""]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let itemSize = puzzleCollectionView.frame.size.width / 4
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)

        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        puzzleCollectionView.collectionViewLayout = layout
    }

    

}
