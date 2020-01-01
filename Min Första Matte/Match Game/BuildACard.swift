////
////  BuildACard.swift
////  Min Första Matte
////
////  Created by Henrik Jangefelt on 2018-11-03.
////  Copyright © 2018 Henrik Jangefelt Nilsson. All rights reserved.
////
//
//import Foundation
//
//// Lägg i Card
//class BuildACard {
//    
//    // Slumpar fram kort (i par) och lägger dem i en array
//    func findCards() -> [MathCard] {
//        
//        // En array för att förvara numren till dem par som redan slumpats fram
//        var randomizedNumbersArray = [Int]()
//        
//        // En array för korten (i par) som slumpats fram
//        var cardDeckArray = [MathCard]()
//        
//        // Medan det finns mindre än 10 kort i arrayen....
//        while randomizedNumbersArray.count < 10 {
//            
//            // Högsta kortet + 1 (eftersom arrays börjar på 0)
//            let randomNumber = arc4random_uniform(10) + 1
//            
//            // Kollar så att det inte redan finns ett likadant par i arrayn innan det nya paret läggs till
//            if randomizedNumbersArray.contains(Int(randomNumber)) == false {
//                
//                // Skriver ut det fram slumpade talet
//                print("Slumpat par: \(randomNumber)")
//                
//                // Lägger talet som slumpats fram i randomizedNumbersArray
//                randomizedNumbersArray.append(Int(randomNumber))
//                
//                // Skapar ett objekt av Card (kort 1)
//                let firstCard = MathCard()
//                
//                // Kortet får en bild baserat på det slumpade numret (Bilderna heter Card01 etc. i assets)
//                firstCard.imageName = "Card\(randomNumber)"
//                
//                // Lägger till kort 1 i cardDeckArray
//                cardDeckArray.append(firstCard)
//                
//                // Nytt objekt av Card (kort 2)
//                let secondCard = MathCard()
//                
//                // Bild till kort 2
//                secondCard.imageName = "Card\(randomNumber)"
//                
//                // Lägger till kort 2 i cardDeckArray
//                cardDeckArray.append(secondCard)
//            }
//        }
//        
//        print(cardDeckArray.count)
//        
//        // Slumpar paren i collection view
//        for i in 0...cardDeckArray.count - 1 {
//            
//            let randomNumber = Int(arc4random_uniform(UInt32(cardDeckArray.count)))
//            
//            // Blandar korten
//            let tempStorage = cardDeckArray[i]
//            cardDeckArray[i] = cardDeckArray[randomNumber]
//            cardDeckArray[randomNumber] = tempStorage
//        }
//        
//        return cardDeckArray
//    }
//}
