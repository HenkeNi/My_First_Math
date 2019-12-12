//
//  AGameOfCardsViewController.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2018-11-03.
//  Copyright © 2018 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

// Rename MemoryGameVC
class AGameOfCardsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var winMessageView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
        // Objekt av buildACard
        var cardBuild = BuildACard()
        var cardArray = [Card]()
        var firstCardTurnedOver: IndexPath?
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Kallar på BuildACard
            cardArray = cardBuild.findCards()
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return cardArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CollectionViewCell
            
            let card = cardArray[indexPath.row]
            
            cell.setCard(card)
            
            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            print("Tryckte på kort \(indexPath.row + 1)")
            
            // Cellen som användaren tryckt på
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            
            // Kortet som användaren tryckt på
            let card = cardArray[indexPath.row]
            
            // Om kortet inte är vänt
            if card.isFlipped == false && card.isPaired == false{
                
                // Vänd kortet
                cell.turn()
                
                card.isFlipped = true
                
                // Om det är första eller andra kortet som blivit vänt
                if firstCardTurnedOver == nil {
                    
                    // Första kortet att vändas
                    firstCardTurnedOver = indexPath
                }
                else {
                    checkIfPaired(indexPath)
                }
            }
        }
        
        // Kollar om korten är ihop parade
        func checkIfPaired(_ secondCardTurnedOver:IndexPath) {
            
            // Hämta cellerna för dem två korten som användaren klickade på
            let cardOneCell = collectionView.cellForItem(at: firstCardTurnedOver!) as? CollectionViewCell
            
            let cardTwoCell = collectionView.cellForItem(at: secondCardTurnedOver) as? CollectionViewCell
            
            // Hämta korten
            let cardOne = cardArray[firstCardTurnedOver!.row]
            let cardTwo = cardArray[secondCardTurnedOver.row]
            
            // Jämför korten
            if cardOne.imageName == cardTwo.imageName {
                
                // matchar
                
                // Sätter korten till
                cardOne.isPaired = true
                cardTwo.isPaired = true
                
                // Ta bort eller sätt korten till att inte gå att vändas!
                cardOneCell?.remove()
                cardTwoCell?.remove()
                
                // Kolla om det finns kort som inte är matchade
                checkGameEnded()
                
            }
            else {
                // Matchar inte
                cardOne.isFlipped = false
                cardTwo.isFlipped = false
                
                // Vänd tillbaka korten
                cardOneCell?.turnBack()
                cardTwoCell?.turnBack()
            }
            
            // Ladda om cellen för första kortet om den är nil
            if cardOneCell == nil {
                collectionView.reloadItems(at: [firstCardTurnedOver!])
            }
            
            // Reseta propertyn som kollar om första kortet är vänt
            firstCardTurnedOver = nil
        }
        
        func checkGameEnded() {
            
            // Kolla om det finns omatchade kort
            var isWon = true
            
            for card in cardArray {
                
                if card.isPaired == false {
                    isWon = false
                    break
                }
            }
            
            // Om alla kort är matchade; Vinst!
            if isWon == true {
                
                print("Vinst!!")
                
                // Lite delay för vinst meddelande
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                    self.view.bringSubviewToFront(self.winMessageView)
                    self.winMessageView.alpha = 1
                }
                
                // Knapp gå tillbaka, knapp avsluta(perform segue)
                
            }
            else {
                print("ERROR!!!!")
            }
            
        }
        
        
        
        
    @IBAction func restartGameButton(_ sender: Any) {
        performSegue(withIdentifier: "quitMatchGame", sender: self)
    }
    
        
}


