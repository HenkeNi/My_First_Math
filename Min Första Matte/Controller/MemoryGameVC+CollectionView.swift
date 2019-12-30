//
//  MemoryGameVC+CollectionView.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-12.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

extension MemoryGameVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    // Amount of cells/cards in the collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }
    
    // The content of a cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! MemoryGameCell
        
        //let card = cardsArray[indexPath.row]
        
        //cell.setCard(card)
        
        return cell
    }
    
    // When pressing/selecting a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! MemoryGameCell
        
        let selectedCard = cardsArray[indexPath.row]
        
        if !selectedCard.isFlipped && !selectedCard.isPaired {
            
            //cell.turnCard()
            
        }
        
        /*if !card.isFlipped && !card.isPaired {
            
            cell.turn()
            
            card.isFlipped = true
            
            if firstCardTurnedOver == nil {
                
                firstCardTurnedOver = indexPath
            } else {
                checkIfPaired(indexPath)
            }
        }*/
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Compute the dimension of a cell for an NxN layout with space S between
        // cells.  Take the collection view's width, subtract (N-1)*S points for
        // the spaces between the cells, and then divide by N to find the final
        // dimension for the cell's width and height.

        let cellsAcross: CGFloat = 4
        let spaceBetweenCells: CGFloat = 1
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        
                
        return CGSize(width: 150, height: 150)
        //return CGSize(width: dim, height: dim)
    }
    
    
    func addSpacingBetweenCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        collectionView.collectionViewLayout = layout
    }
    
    
    /*
        
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
    }*/
    
    
//    func setCellSize() {
//
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//
//        // Cellsize
//        let width = (view.frame.width)/2
//        layout.itemSize = CGSize(width: width, height: width)
//
//        // Cell spacing
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 20)
//        //layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
//        layout.minimumInteritemSpacing = 2
//        layout.minimumLineSpacing = 2
//        collectionView!.collectionViewLayout = layout
//    }
    
    
}
