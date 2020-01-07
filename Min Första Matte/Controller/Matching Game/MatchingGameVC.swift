//
//  MatchingGameVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit


// TODO: Choose gridsize (4x4, 5x5, etc..)
// TODO: Alert ruta: 1. replay (choose gridsize) 2. Go Back
// TODO: Timer?
// TODO: FLip back numbers when pressing new ones (instead of waiting)
class MatchingGameVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var cards = [MatchingCard]()
    var cardGenerator: CardGenerator?
    var flippedCards = [MatchingCard]()
    var tapCardIsPossible: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.appearance().isExclusiveTouch = true // Disable multi touch
        fetchCards()
    }
    
    
    func fetchCards() {
       
        cardGenerator = CardGenerator()
        
        if let generator = cardGenerator {
            cards = generator.getCards(amount: 8)
        }
    }
    
    
    
    func trackFlippedCards(card: MatchingCard) {
          
          if flippedCards.count < 2 {
              flippedCards.append(card)
              if flippedCards.count == 2 {
                  checkForPairs(cards: flippedCards)
                  flippedCards.removeAll()
              }
          }
          
          /*switch flippedCards.count {
          case _ where flippedCards.count == 0:
              flippedCards.append(card)
          case _ where flippedCards.count > 0:
              checkForPairs(cards: flippedCards)
              flippedCards.removeAll()
          /*case _ where flippedCards.count < 2:
              flippedCards.append(card)
          case _ where flippedCards.count == 2:
              checkForPairs(cards: flippedCards)
              flippedCards.removeAll()*/
          default:
              break
          }*/
      }
    
    


    
    
    func checkForPairs(cards: [MatchingCard]) {
                
        tapCardIsPossible = false
        
        cards[0].number == cards[1].number ? isAPair(cards: cards) : isNotAPair(cards: cards)
        checkForGameWon()
    }

    
    func isAPair(cards: [MatchingCard]) {
        for card in cards {
            card.isPaired = true
                   
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.removeCard(card: card)
                self.tapCardIsPossible = true
            }
        }
    }
    
    func isNotAPair(cards: [MatchingCard]) {
        for card in cards {
            let cell = collectionView.cellForItem(at: card.indexPath!) as! MatchingGameCell
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                cell.flipCard(card: card)
                self.tapCardIsPossible = true
            }
        }
    }
    
    
    
    func removeCard(card: MatchingCard) {
        
        let cell = collectionView.cellForItem(at: card.indexPath!) as! MatchingGameCell
        cell.removeCard(card: card)
    }
    

    func checkForGameWon() {
        
        for card in cards where !card.isPaired { return }
        
        print("GAME WON!!")
        // TODO: ALERT RUTA!!
    }
    
    
    
    // FIX
    // TODO: Get new array of cards?
    func restartGame() {
        
        for card in cards {
            card.isPaired = false
            card.isFlipped = false
            
            let cell = collectionView.cellForItem(at: card.indexPath!) as! MatchingGameCell
            cell.setCardImage(card: card)
            cell.cardView.alpha = 1
        }
        tapCardIsPossible = true
    }
    
    
    deinit {
        cardGenerator = nil
    }
    

}
