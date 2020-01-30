////
////  EquationCards.swift
////  Min Första Matte
////
////  Created by Henrik Jangefelt on 2020-01-30.
////  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
////
//
//import Foundation
//
//class EquationCards {
//    
//    var cards = [MathCard]() // OPTIONAL?
//    
//    
//    init() {
//        
//    }
//    
//    func addCards() {
//        for _ in 1...3 {
//            cards.append(MathCard())
//        }
//    }
//    
//    var answerViewIndex: Int {
//        get {
//            for (index, card) in cards.enumerated() where card.isAnswerView {
//                return index
//            }
//        }
//        set {
//            
//        }
//    }
//    
//    
//    
//    func setEquationCardNumbers(numbers: [Int]) {
//        
//    }
//    
//    
//    
//    
//    func getCurrentEquationCardNumbers() -> [Int] {
//           
//        var equationsNumbers = [Int]()
//           
//        for card in equationCards where !card.isAnswerView {
//            equationsNumbers.append(card.number)
//        }
//        return equationsNumbers
//    }
//    
//    
//    
//    // LÄGG LITE AV LOGIKEN I EASYMATH
//    func getNumbersInEquation(chosenNumber: Int) -> (firstNumber: Int, secondNumber: Int, resultNumber: Int) {
//             
//             let equationNumbers = getCurrentEquationCardNumbers()
//
//             switch getAnswerViewIndex() {
//             case 0:
//                 return (chosenNumber, equationNumbers[0], equationNumbers[1])
//             case 1:
//                 return (equationNumbers[0], chosenNumber, equationNumbers[1])
//             case 2:
//                 return (equationNumbers[0], equationNumbers[1], chosenNumber)
//             default:
//                 return (0, 0, 0) // TODO: FIX!
//             }
//         }
//    
//    
//    // Sets property of isAnswerView in equationCards
//      // setCurrentAnswerView
//      func setIsAnswerViewProperty(currentIndex: Int) {
//          
//          for (index, card) in equationCards.enumerated() {
//              card.isAnswerView = index == currentIndex ? true : false
//          }
//      }
//    
//    
//    
//    // Returns correct answerView index/position for current difficulty
//    func getAnswerViewIndex(difficulty: EasyMathVC.Difficulty) -> Int {
//        switch difficulty {
//        case .easy:
//            return 2
//        case .medium:
//            return 2
//        case .hard:
//            return 1
//        case .veryHard:
//            return 0
//        case .impossible:
//            
//            // TODO: ÄNDRA /eller/ EGEN FUNKTION
//            if randomAnswerViewIndex != nil {
//                if let randomAnswerViewIndex = randomAnswerViewIndex { return randomAnswerViewIndex }
//            } else {
//                randomAnswerViewIndex = Int.random(in: 0...2)
//                
//                if let randomAnswerViewIndex = randomAnswerViewIndex { return randomAnswerViewIndex}
//            }
//            return randomAnswerViewIndex!
//        }
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    deinit {
//        <#statements#>
//    }
//}
