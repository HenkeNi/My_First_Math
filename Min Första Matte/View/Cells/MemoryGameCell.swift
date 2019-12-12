//
//  MemoryGameCell.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-12.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class MemoryGameCell: UICollectionViewCell {
    
    @IBOutlet weak var cardFace: UIImageView!
    @IBOutlet weak var cardBack: UIImageView!
    
    // Lägg logik för turn (en imageView samt remove i klassen för card)
    var card: MemoryCard?
    
    func setCard(_ card: MemoryCard) {
        
        self.card = card
        
        if card.isPaired == true {
        
        // isHidden istället???
        cardFace.alpha = 0
        cardBack.alpha = 0
        
        return
    } else {
        cardFace.alpha = 1
        cardBack.alpha = 1
    }
        
        cardFace.image = UIImage(named: card.imageName)
        
        if card.isFlipped == true {
            
            UIView.transition(from: cardBack, to: cardFace, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: cardFace, to: cardBack, duration: 0, options: [.showHideTransitionViews, .transitionFlipFromRight], completion: nil)
        }
    }
    
    func turn() {
        
          UIView.transition(from: cardBack, to: cardFace, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    func turnBack() {
        
        // Skapar en delay innan korten vänds tillbaka
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            
            UIView.transition(from: self.cardFace, to: self.cardBack, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
        
        
    func remove() {
        cardBack.alpha = 0
            
        // Ta bort båda korten
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
                
            self.cardFace.alpha = 0
                
        }, completion: nil)
            
    }
}
