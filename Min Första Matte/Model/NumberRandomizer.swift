//
//  NumberRandomizer.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-09-11.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

// Extension av INt istället?
// TODO: returnera 0 mer sällan
class NumberRandomizer {
    
//    var previousNumbers = [0, 0]
//    
//    // TODO: rename randomizeNumbers
//    func numberRandomizer(condition: (Int, Int) -> Bool) -> [Int] {
//         
//        var firstNumber: Int
//        var secondNumber: Int
//        
//        repeat {
//            firstNumber = Int.random(in: 0...10)
//            secondNumber = Int.random(in: 0...10)
//            //print("Randomizing")
//        } while condition(firstNumber, secondNumber) || (firstNumber == previousNumbers[0] && secondNumber == previousNumbers[1])
//        
//        previousNumbers[0] = firstNumber
//        previousNumbers[1] = secondNumber
//        
//        return [firstNumber, secondNumber]
//    }
//    
    
    
    
    
    //typealias equationNumbers = (firstNumb: Int, secondNumb: Int, result: Int)
    //typealias arithmetic = (_ lhs: Int, _ rhs: Int) -> Int
     
     
    // TODO: Gör om med tuple?
    func randomizeNumbers(playableCards: [Int], answerIndex: Int, arithmetic: CalculationMode) -> [Int] {
         
        var equationNumbers: [Int]
        
//                var firstNumber: Int
//                var secondNumber: Int
//                var result: Int
               // var final: [Int]
        
                 repeat {
                    //equationNumbers.removeAll()
                    
                    let firstNumber = Int.random(in: 0...10)
                    let secondNumber = Int.random(in: 0...10)
                    let result = getSum(numbers: [firstNumber, secondNumber], arithmetic: arithmetic)
                    
                    equationNumbers = [firstNumber, secondNumber, result]
                    //final = [firstNumber, secondNumber, result]

                 } while equationNumbers.last! < playableCards.first! || equationNumbers.last! > playableCards.last! || !playableCards.contains(equationNumbers[answerIndex])
                
        print(equationNumbers)
        return equationNumbers
     }
    
    
    
    // extensio of Int? // ENUM??
    func getSum(numbers: [Int], arithmetic: CalculationMode) -> Int {
        
        switch arithmetic {
        case .addition:
            return numbers.reduce(0, +)
        case .subtraction:
            return numbers.reduce(numbers[0] + numbers[0], -)
        case .multiplication:
            if numbers[0] == 0 || numbers[1] == 0 { return -31 }
            return numbers.reduce(1, *)
        case .division:
            if numbers[0] == 0 || numbers[1] == 0 { return -31 }
 
            let value = Double(numbers[0]) / Double(numbers[1])
            
            if value.truncatingRemainder(dividingBy: 1) == 0 {
                return numbers[0] / numbers[1]
            }
            return -31
        }
    }
    
    
    deinit {
        print("NumberRandomizer will be deallocated")
    }
    
}

