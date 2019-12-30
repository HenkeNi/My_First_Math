//
//  MemoryGameCell.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-12.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class MemoryGameCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardImage: UIImageView!
    
    
    
    // Lägg logik för turn (en imageView samt remove i klassen för card)
    var card: MemoryCard?
    
    func setCard(_ card: MemoryCard) {
        
        self.card = card
        
        if card.isPaired == true {
        
            // isHidden istället???
            
            cardView.alpha = 0
        
            return
        } else {
            cardView.alpha = 1
        }
        
        cardImage.image = UIImage(named: card.imageName)
        
        if card.isFlipped == true {
            
            card.turnCard(cardView: cardView)
            
            /*UIView.transition(from: cardBack, to: cardFace, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)*/
        } else {
            
            card.turnCard(cardView: cardView)
            //card.flipCardBack()
            /*UIView.transition(from: cardFace, to: cardBack, duration: 0, options: [.showHideTransitionViews, .transitionFlipFromRight], completion: nil)*/
        }
    }
    
    
    
    

        
        
    /*func remove() {
        cardBack.alpha = 0
            
        // Ta bort båda korten
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
                
            self.cardFace.alpha = 0
                
        }, completion: nil)
            
    }*/
}
