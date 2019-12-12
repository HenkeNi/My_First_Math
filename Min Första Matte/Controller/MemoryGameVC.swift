//
//  MemoryGameVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-12.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

// TODO: väntetid när man vänt två siffror??
// TODO: använd nummer till varje card i logiken
// TODO: back knapp funkar inte (kraschar när man är klar)
class MemoryGameVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var endGameView: UIView!
    
    
    var cardsArray = [MemoryCard]()
    var memoryCard = MemoryCard()
    
    var firstCardTurnedOver: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardsArray = memoryCard.findCards()
        endGameView.isHidden = true
        
        cellSize()
    }
    
    
    func checkGameEnded() {
        
        var isWon = true
        
        for card in cardsArray {
            
            if card.isPaired == false {
                // No win
                isWon = false
                break
            }
        }
        
        if isWon == true {
            // Win
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                // Bring win view to front
                self.view.bringSubviewToFront(self.endGameView)
                    self.endGameView.isHidden = false
                
            }
        }
    }
    

}
