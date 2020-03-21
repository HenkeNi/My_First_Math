//
//  MatchingGameCell.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class MatchingGameCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardImage: UIImageView!
    
    func customizeCardView() {
        cardView.roundedCorners(myRadius: 20, borderWith: 5, myColor: .darkGray)
    }
    
    func setCardImage(card: MatchingCard) {
        cardImage.image = UIImage(named: card.imageName)
    }
    
    func flipCard(card: MatchingCard) {
        cardView.flipView(duration: 0.3)
        //card.flipCard(cardView: cardView)
        //setCardImage(card: card)
    }
    
    func removeCard(card: MatchingCard) {
        UIView.animate(withDuration: 0.5) {
            self.cardView.alpha = 0
        }
    }
    
}
