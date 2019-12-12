//
//  MemoryGameVC+CollectionView.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-12.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

extension MemoryGameVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! MemoryGameCell
        
        let card = cardsArray[indexPath.row]
        
        cell.setCard(card)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! MemoryGameCell
        
        let card = cardsArray[indexPath.row]
        
        if !card.isFlipped && !card.isPaired {
            
            cell.turn()
            
            card.isFlipped = true
            
            if firstCardTurnedOver == nil {
                
                firstCardTurnedOver = indexPath
            } else {
                checkIfPaired(indexPath)
            }
        }
    }
    
        
    func checkIfPaired(_ secondCardTurnedOver: IndexPath) {
        
        let cardOneCell = collectionView.cellForItem(at: firstCardTurnedOver!) as? MemoryGameCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondCardTurnedOver) as? MemoryGameCell
        
        let cardOne = cardsArray[firstCardTurnedOver!.row]
        
        let cardTwo = cardsArray[secondCardTurnedOver.row]
        
        // KOlla nummer istället??
        if cardOne.imageName == cardTwo.imageName {
            
            // Match
            cardOne.isPaired = true
            cardTwo.isPaired = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            checkGameEnded()
        } else {
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.turnBack()
            cardTwoCell?.turnBack()
        }
        
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstCardTurnedOver!])
        }
        
        firstCardTurnedOver = nil
    }
    
    
    func cellSize() {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        // Cellsize
        let width = (view.frame.width)/6
        layout.itemSize = CGSize(width: width, height: width)
        
        // Cell spacing
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        //layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        collectionView!.collectionViewLayout = layout
    }
    
    
}
