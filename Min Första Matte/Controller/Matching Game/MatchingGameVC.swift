//
//  MatchingGameVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class MatchingGameVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var cards = [MatchingCard]()
    var cardGenerator: CardGenerator?
    
    var flippedCards = [MatchingCard]()
    var tapCardIsPossible: Bool = true
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.appearance().isExclusiveTouch = true // Disable multi touch
        getCards()
    }
    
    
    // Make own class
    func getCards() {
        
        let card1 = MatchingCard(number: 1)
        let card1Copy = MatchingCard(number: 1)
        cards += [card1, card1Copy]
    
        let card2 = MatchingCard(number: 2)
        let card2Copy = MatchingCard(number: 2)
        cards += [card2, card2Copy]
        
        let card3 = MatchingCard(number: 3)
        let card3Copy = MatchingCard(number: 3)
        cards += [card3, card3Copy]
        
        let card4 = MatchingCard(number: 4)
        let card4Copy = MatchingCard(number: 4)
        cards += [card4, card4Copy]
        
        let card5 = MatchingCard(number: 5)
        let card5Copy = MatchingCard(number: 5)
        cards += [card5, card5Copy]
        
        let card6 = MatchingCard(number: 6)
        let card6Copy = MatchingCard(number: 6)
        cards += [card6, card6Copy]
        
        let card7 = MatchingCard(number: 7)
        let card7Copy = MatchingCard(number: 7)
        cards += [card7, card7Copy]
        
        let card8 = MatchingCard(number: 8)
        let card8Copy = MatchingCard(number: 8)
        cards += [card8, card8Copy]
   
        
        
        
        /*cardGenerator = CardGenerator()
        
        if let generator = cardGenerator {
            cards = generator.getCards(amount: 8)
        }*/
    }
    
    
    
    
    
    

    //
    func checkForPairs(cards: [MatchingCard]) {
                
        tapCardIsPossible = false
        
        if cards[0].number == cards[1].number {
            print("PAR!!!")
            
            for card in cards {
                card.isPaired = true
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.removeCard(card: card)
                }
            }
            tapCardIsPossible = true

            
        } else {
            for card in cards {
                print("EJ PAR!")
                let cell = collectionView.cellForItem(at: card.indexPath!) as! MatchingGameCell
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    cell.flipCard(card: card)
                    self.tapCardIsPossible = true
                }
                
            }
        }
        
        
        /*if cardOne.number == cardTwo.number {
            print("SAmeE")
            cardOne.isPaired = true
            cardTwo.isPaired = true
            //removeCards(cardOne: cardOne, cardTwo: cardTwo)
        } else {
            return
        }*/
        checkForGameWon()
    }

    
    func isAPair() {
        
    }
    
    func isNotAPair() {
        
    }
    
    func removeCard(card: MatchingCard) {
        let cell = collectionView.cellForItem(at: card.indexPath!) as! MatchingGameCell
        cell.removeCard(card: card)
    }
    
    func removeCards(cards: [MatchingCard]) {
        
        for card in cards {
            let cell = collectionView.cellForItem(at: card.indexPath!) as! MatchingGameCell
            cell.removeCard(card: card)
        }
    }
    
    
    
    func checkForGameWon() {
        
        for card in cards where !card.isPaired { return }
        
        print("GAME WON!!")
        // TODO: ALERT RUTA!!
    }
    
    
    
    

}
