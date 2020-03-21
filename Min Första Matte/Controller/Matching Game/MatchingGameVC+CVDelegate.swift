//
//  MatchingGameVC+CVDelegate.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

extension MatchingGameVC: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as! MatchingGameCell
        let card = cards[indexPath.row]
        
        if tapCardIsPossible && !card.isFlipped {
            cell.flipCard(card: card)
            
            cards[indexPath.row].isFlipped = true
            cell.setCardImage(card: cards[indexPath.row])
            
            
            trackFlippedCards(card: card)
        }
    }
    
  
    
}
