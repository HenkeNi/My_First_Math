//
//  MatchingGameVC+CVFlowLayout.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

// TODO: rename CVDelFlowLayout
extension MatchingGameVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cardAmountSqrd = Double(cards.count).squareRoot()
        //let roundedCardAmount = cardAmountSqrd.rounded(.awayFromZero)
        
        //print("Card in row: \(cardAmountSqrd.rounded(.awayFromZero))")
        
        let cardWidth = collectionView.frame.size.width / CGFloat(cardAmountSqrd)
        
        return CGSize(width: cardWidth, height: cardWidth)
    }
    
}
