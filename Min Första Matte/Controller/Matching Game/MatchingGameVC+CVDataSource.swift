//
//  MatchingGameVC+CVDataSource.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

extension MatchingGameVC: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! MatchingGameCell
        
        
        let card = cards[indexPath.row]
        card.indexPath = indexPath
        
        cell.customizeCardView()
        cell.setCardImage(card: card)
        return cell
    }
    
    
}
