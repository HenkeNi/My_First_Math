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
//        print(card.number)
//        print(card.indexPath)
        print(card.isFlipped)
        if tapCardIsPossible && !card.isFlipped {
            cell.flipCard(card: card)
                   
            if flippedCards.count < 2 {
                flippedCards.append(card)
                if flippedCards.count == 2 {
                    checkForPairs(cards: flippedCards)
                    flippedCards.removeAll()
                }
            }
        }
        
       
        
        
        
        /*if !firstCardFlipped {
            firstCardFlipped = true
            firstCard = card
            print("First Card")
        } else if !secondCardFlipped {
            secondCardFlipped = true
            secondCard = card
            print("Second Card")
            checkForPairs(cardOne: firstCard!, cardTwo: secondCard!)
            firstCardFlipped = false
            secondCardFlipped = false
            
            if firstCard!.isPaired && secondCard!.isPaired {
                cell.hideCard(card: firstCard!)
                cell.hideCard(card: secondCard!)
            }
        }*/
        

        
        
        
        //cards[indexPath.row].isFlipped = true // TODO: Change
        
        
    }
    
}
