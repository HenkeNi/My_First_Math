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
    
    var previousNumbers = [0, 0]
    
    // TODO: rename randomizeNumbers
    func numberRandomizer(condition: (Int, Int) -> Bool) -> [Int] {
         
        var firstNumber: Int
        var secondNumber: Int
        
        repeat {
            firstNumber = Int.random(in: 0...10)
            secondNumber = Int.random(in: 0...10)
            //print("Randomizing")
        } while condition(firstNumber, secondNumber) || (firstNumber == previousNumbers[0] && secondNumber == previousNumbers[1])
        
        previousNumbers[0] = firstNumber
        previousNumbers[1] = secondNumber
        
        return [firstNumber, secondNumber]
    }
    
    
    
    
    
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
            return numbers.reduce(1, *)
        }
    }
    
    
//
//    func randomizeNumbers(playableCards: [Int], answerIndex: Int, arithmetic: CalculationMode) -> [Int] {
//
//        var equationNumbers: [Int]
//
//
//
//                var firstNumber: Int
//                var secondNumber: Int
//                var result: Int
//                var final: [Int]
//
//                 repeat {
//                     firstNumber = Int.random(in: 0...10)
//                     secondNumber = Int.random(in: 0...10)
//
//                    result = getSum(numbers: [firstNumber, secondNumber], arithmetic: arithmetic)
//                    final = [firstNumber, secondNumber, result]
//
//                 } while result < playableCards.first! || result > playableCards.last! || !playableCards.contains(final[answerIndex])
//                 return final
//     }
//
    
    

    
    
    
    
    
    
    
//    typealias RandomizeCondition = (firstNumb: Int, secondNumb: Int, value: Int)
    // TEST
//    let basicAdditionCondition = { (condition: RandomizeCondition) -> Bool in
//        return condition.firstNumb + condition.secondNumb < condition.maxNumb &&
//            condition.firstNumb + condition.secondNumb > condition.minNumb
//    }

//    let additionMiniCondition: (RandomizeCondition) -> Bool = { (firstNumb: Int, secondNu) in
//        return
//    }
    
    
    
//    let additionMinCondition: (Int, Int, Int) -> Bool = { return $0 + $1 > $2 }
//    let additionMaxCondition: (Int, Int, Int) -> Bool = { return $0 + $1 < $2 }
    
//
//    let easyAdditionCondition: (Int, Int) -> Bool =    { return $0 + $1 > 5 || $0 + $1 < 1 }
//    let mediumAdditionContidion: (Int, Int) -> Bool =  { return $0 + $1 < 6 || $0 + $1 > 10 }
//
//    let hardAdditionCondition: (Int, Int) -> Bool =    { return $1 - $0 > 5 || $1 - $0 < 1 }
//    let veryHardAdditionConditio: (Int, Int) -> Bool = { return $1 - $0 < 6 || $1 - $0 > 10 }
//
//
//    // x + y = ?
//    let impossibleAdditionCondition1: (Int, Int) -> Bool = {
//        return $0 + $1 > 10
//    }
//
//    // x + ? = y && ? + x = y
//    let impossibleAdditionCondition2: (Int, Int) -> Bool = {
//        return $1 - $0 > 10 || $1 - $0 < 1
//    }
//
//
//
//
//    let easySubtractionCondition: (Int, Int) -> Bool = { return $0 - $1 < 0 || $0 - $1 > 4 || $0 > 5 || $1 > 4 }
//
//    let mediumSubtractionCondition: (Int, Int) -> Bool = { return $0 - $1 < 5 || $0 - $1 > 9 }
//    let hardSubtractionCondition: (Int, Int) -> Bool = { return $0 - $1 > 4 || $0 - $1 < 1 }
//
//    let veryHardSubtractionCondition: (Int, Int) -> Bool = {
//        return $0 + $1 > 9 || $0 + $1 < 5
//    }
//
//    // TODO: FIX
//
//    //  x - y = ?
//    let impossibleSubtractionCondition1: (Int, Int) -> Bool = {
//        print("COND 1")
//        return $0 - $1 < 0 || $0 - $1 > 9 // Sista delen behövs?
//    }
//
//    // 5 - ? = 3
//    // x - ? = y
//    let impossibleSubtractionCondition2: (Int, Int) -> Bool = {
//        print("COND 2")
//        return $0 - $1 > 9 || $0 - $1 < 1
//    }
//
//    // ? - x = y
//    let impossibleSubtractionCondition3: (Int, Int) -> Bool = {
//        print("COND 3")
//        return $0 + $1 > 9 || $0 + $1 < 0
//    }
//
//
////    let impossibleSubtractionCondition: (Int, Int) -> Bool = {
////        return $0 - $1 < 5
////    }
//
//
//    // x * y = ?
//    let basicMultiplicationCondition: (Int, Int) -> Bool = {
//        return $0 * $1 > 10
//    }
//
//    // x * ? = y  2 * ? = 6
//    let intermediateMultiplicationCondition: (Int, Int) -> Bool = {
//
//        if $0 == 0 || $1 == 0 { return true }
//
//        let value = Double($1) / Double($0)
//        //let isInteger = value.truncatingRemainder(dividingBy: 1) == 0
//        //if value == Double(Int(value)) {
//        if value.truncatingRemainder(dividingBy: 1) == 0 {
//            // Not decimal
//            return $1 / $0 > 10 && $1 / $0 <= 0
//        }
//
//
////        if ($1 / $0) % 1 == 0 && $1 / $0 != 0 {
////            return $1 / $0 > 10 && $1 / $0 <= 0
////        }
//        return true
////        if ($1 / $0) % 1 != 0 { return true }
////        return $1 / $0 > 10 && $1 / $0 <= 0
//    }
//
//
//
////    let advancedMultiplicationCondition: (Int, Int) -> Bool = {
////        return
////    }
//
//    let easyMultiplicationCondition: (Int, Int) -> Bool = {
//        return $0 * $1 > 5
//    }
//
//    let mediumMultiplicationCondition: (Int, Int) -> Bool = {
//        return $0 * $1 < 6 || $0 * $1 > 10
//    }
//
//    let hardMultiplicationCondition: (Int, Int) -> Bool = {
//        return $1 / $0 > 5
//    }
//
//    let veryHardMultiplicationCondition: (Int, Int) -> Bool = {
//        return $1 / $0 > 10 || $1 / $0 < 6
//    }
//
//    // TODO: FIX
//    let impossibleMultiplicationCondition: (Int, Int) -> Bool = {
//        return $0 * $1 > 5
//    }
    
    
    deinit {
        print("NumberRandomizer will be deallocated")
    }
    
}
