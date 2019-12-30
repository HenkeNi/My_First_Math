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
    
    var cards = [Card]()
    var cardGenerator: CardGenerator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardGenerator = CardGenerator()
        getCards()
    }
    
    
    // Make own class
    func getCards() {
        
        if let generator = cardGenerator {
            cards = generator.getCards(amount: 8)
        }
        
        for card in cards {
            card.isFlipped = false
            print(card.number)
        }
        
        print(cards.count)
    }



}
