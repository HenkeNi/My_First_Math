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
    
    func displayCards(card: Card) {
        
        cardImage.image = UIImage(named: card.imageName)
        
    }
}
