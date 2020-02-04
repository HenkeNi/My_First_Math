//
//  NumberRandomizer.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-09-11.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

// Extension av INt istället?
// TODO: Lägg till 0 för plus?? 4 + 0 etc..
// TODO: not same numbers in a row
class NumberRandomizer {
    
    /*func randomizeTwoNumbers(mathMode : CalculationMode) -> (Int, Int) {
        
        var firstNumber: Int
        var secondNumber: Int
    
        let startNumber = mathMode == .addition ? 1 : 0
        
        repeat {
            firstNumber = Int.random(in: startNumber...4)
            secondNumber = Int.random(in: startNumber...4)
        } while mathMode == .addition ? firstNumber + secondNumber > 5 : firstNumber - secondNumber < 0
                
     return (firstNumber, secondNumber)
    }*/
    var previousResult = 0
    
    
    func numberRandomizer(condition: (Int, Int) -> Bool) -> [Int] {
         
        var firstNumber: Int
        var secondNumber: Int
        
        repeat {
            firstNumber = Int.random(in: 1...10)
            secondNumber = Int.random(in: 1...10)
            //firstNumber = Int.random(in: startNumber...endNumber)
            //secondNumber = Int.random(in: startNumber...endNumber)
        } while condition(firstNumber, secondNumber) || (firstNumber + secondNumber == previousResult)
        
        //previousResult = firstNumber + secondNumber
        //print("Prev \(previousResult)")
        
       // return (firstNumber, secondNumber)
        previousResult = firstNumber + secondNumber
        
        return [firstNumber, secondNumber]
    }
    
    
    
    // TEST
    let basicAdditionCondition = { (firstNumb: Int, secondNumb: Int, maxValue: Int) -> Bool in
            return firstNumb + secondNumb > maxValue
    }
        
        
    
    
    let easyAdditionCondition: (Int, Int) -> Bool = {
        return $0 + $1 > 5
    }
    
    let mediumAdditionContidion: (Int, Int) -> Bool = {
        return $0 + $1 < 6 || $0 + $1 > 10
    }
    
    let hardAdditionCondition: (Int, Int) -> Bool = { 
        return $1 - $0 > 5 || $1 - $0 < 1
    }
    
    let veryHardAdditionConditio: (Int, Int) -> Bool = {
        return $1 - $0 < 6 || $1 - $0 > 10
    }
    
    
    // x + y = ?
    let impossibleAdditionCondition1: (Int, Int) -> Bool = {
        return $0 + $1 > 10
    }
    
    // x + ? = y && ? + x = y
    let impossibleAdditionCondition2: (Int, Int) -> Bool = {
        return $1 - $0 > 10 || $1 - $0 < 1
    }
    
    
    
    
    let easySubtractionCondition: (Int, Int) -> Bool = {
        return $0 - $1 < 0 || $0 - $1 > 4 || $0 > 5 || $1 > 4
    }
    
    let mediumSubtractionCondition: (Int, Int) -> Bool = {
        return $0 - $1 < 5 || $0 - $1 > 9
    }
    
    let hardSubtractionCondition: (Int, Int) -> Bool = {
        return $0 - $1 > 4 || $0 - $1 < 1
    }
    
    let veryHardSubtractionCondition: (Int, Int) -> Bool = {
        return $0 + $1 > 9 || $0 + $1 < 5
    }
    
    // TODO: FIX
    let impossibleSubtractionCondition: (Int, Int) -> Bool = {
        return $0 - $1 < 5
    }
    
 
    
    
    
    let easyMultiplicationCondition: (Int, Int) -> Bool = {
        return $0 * $1 > 5
    }
    
    let mediumMultiplicationCondition: (Int, Int) -> Bool = {
        return $0 * $1 < 6 || $0 * $1 > 10
    }
    
    let hardMultiplicationCondition: (Int, Int) -> Bool = {
        return $1 / $0 > 5
    }
    
    let veryHardMultiplicationCondition: (Int, Int) -> Bool = {
        return $1 / $0 > 10 || $1 / $0 < 6
    }
    
    // TODO: FIX
    let impossibleMultiplicationCondition: (Int, Int) -> Bool = {
        return $0 * $1 > 5
    }
    
    
 
    
}
