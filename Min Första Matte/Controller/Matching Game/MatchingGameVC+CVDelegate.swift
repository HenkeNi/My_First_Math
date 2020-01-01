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
        
        print("Pressed \(indexPath.row)")
        cards[indexPath.row].isFlipped = true
    }
    
}
