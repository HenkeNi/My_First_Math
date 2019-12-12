//
//  CollectionViewCell.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2018-11-03.
//  Copyright © 2018 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
        
        @IBOutlet weak var cardFace: UIImageView!
        @IBOutlet weak var cardBack: UIImageView!
        
    
        var card: Card?
        
        func setCard(_ card:Card) {
            
            // Håller reda på kortet som skickas in
            self.card = card
            
            if card.isPaired == true {
                
                // Gör korten osynliga om dem matchar
                // Gör om till isHidden istället?
                cardFace.alpha = 0
                cardBack.alpha = 0
                
                return
            }
            else {
                
                // Gör korten synliga om dem inte har matchat
                cardBack.alpha = 1
                cardFace.alpha = 1
            }
            
            // OM EN BILD ÄR TOM NÄR DEN FLIPPAS, KOLLA HÄR (kolla imageName finns!)!!
            
            // Sätter bild på frontImageView
            cardFace.image = UIImage(named: card.imageName)
            
            // Kolla om kortet är vänt eller inte
            if card.isFlipped == true {
                
                // FrontImageView är ovanför
                UIView.transition(from: cardBack, to: cardFace, duration: 0, options: [.transitionFlipFromLeft, . showHideTransitionViews], completion: nil)
            }
            else {
                // BackImageView är ovanför
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


