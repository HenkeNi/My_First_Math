//
//  CardGameVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-10-02.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit


// Ens egna "kortlek" nere till höger (siffra ovanför som vissar antal kort kvar) (siffra byts till "Winning!" vid vinst för att mer vissa vem som vann.....
// målet att bli av med sina kort? eller motståndaren först?


// Rotera views

// TODO: collectionView för korten??
class CardGameVC: UIViewController {

    
    @IBOutlet var playerCardViews: [UIView]!
    
    @IBOutlet weak var cardPlacementView: UIView!
    
    var playerOriginalPosition: CGPoint!
    var isFirstCard = true
    
    
    var players = [CardPlayer]()
    var playerCards = [GameCard]()
    var computerCards = [GameCard]()
    
    var cardDeck = CardDeck()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.appearance().isExclusiveTouch = true
        
        var playerOne = CardPlayer()
        var computer = CardPlayer()
        players.append(playerOne)
        players.append(computer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        savePlayerCardOriginalPosition()
    }
    
    
    
    
    func startGame() {
        
        for player in players {
            
            var index = 0
                 for card in cardDeck.deckOfCards where index <= cardDeck.deckOfCards.count / 2 {

            }
            
        }
        
        
     
        
    }
    
    
    
    
    
    func originalCardPosition() {
    
        for playerCard in playerCardViews {
            playerCard.center = playerOriginalPosition
        }
    }
    
    func savePlayerCardOriginalPosition() {
        
        // TODO: Funkar med att bådas position sparas (skriver över varandra)???
        for playerCard in playerCardViews {
            playerOriginalPosition = playerCard.center
        }
    }
    
    

    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
      let translation = recognizer.translation(in: self.view)
      if let view = recognizer.view {
        view.center = CGPoint(x:view.center.x + translation.x,
                                y:view.center.y + translation.y)
      }
      recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        /*if recognizer.state == .began {
            //self.view.bringSubviewToFront(recognizer.view!)
        }*/
        
        if recognizer.state == .ended {
            
            var distanceToCardHolder = abs(cardPlacementView.center.x - recognizer.view!.center.x)
            distanceToCardHolder += abs(cardPlacementView.center.y - recognizer.view!.center.y)
            
            print(distanceToCardHolder)
            print(recognizer.view?.center)
            
            if distanceToCardHolder < 100 {
                                
                isFirstCard = !isFirstCard
                let viewToFront = isFirstCard ? playerCardViews[0] : playerCardViews[1]
                
                
                cardPlacementView.backgroundColor = recognizer.view?.backgroundColor
           
                view.bringSubviewToFront(viewToFront)

            }
            
            originalCardPosition()
            
        }
    }
 

}
