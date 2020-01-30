////
////  PlayableCards.swift
////  Min Första Matte
////
////  Created by Henrik Jangefelt on 2020-01-30.
////  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
////
//
//import Foundation
//
//// TODO: cards || cardCollection protocol????
//class PlayableCards {
//
//    var cards = [MathCard]()
//
//    init() {
//       addCards()
//    }
//
//    func addCards() {
//        for _ in 1...5 {
//            cards.append(MathCard())
//        }
//    }
//
//
//    // Två funktioner updateCardNumbers och getCardNumbers?
//
//
//    // RENAME
//    func setCardNumbers(numbers: [Int]) {
//        for (index, card) in cards.enumerated() {
//            card.number = numbers[index]
//        }
//    }
//
//    // RENAME
//    func getCardNumbers() {
//
//        let range = 1...5
//
//        for (index, i) in range.enumerated() {
//            cards[index].number = i
//        }
//
//    }
//
//
//    // Ta in en optional nummer för rätt svar? Eller ha en EquationCard array i property?
//    func getAddRangeForImpossible() -> [Int]{
//
//        var numbs = [Int]()
//        var usedNumbs = [Int]()
//
//        repeat {
//            numbs
//        }
//    }
//
//    func getCardNumberRange(difficulty: EasyMathVC.Difficulty, mathMode: CalculationMode) -> [Int] {
//
//        switch (difficulty, mathMode)  {
//
//        case (.easy, .addition), (.hard, .addition), (.easy, .multiplication), (.hard, .multiplication):
//              return [1, 2, 3, 4, 5]
//        case (.medium, .addition), (.veryHard, .addition), (.medium, .multiplication), (.veryHard, .multiplication):
//              return [6, 7, 8, 9, 10]
//
//        case (.impossible, .addition), (.impossible, .multiplication):
//              return getAddRangeForImpossible()
//
//          case (.easy, .subtraction), (.hard, .subtraction):
//              return [0, 1, 2, 3, 4]
//          case (.medium, .subtraction), (.veryHard, .subtraction):
//              return [5, 6, 7, 8, 9]
//
//          // FIX
//          case (.impossible, .subtraction):
//               return [4, 5, 6, 7, 8] // FIX
//              //return [4...8] // FIX
//
//          }
//    }
//
//
//
//
//
//
//
//
//}
