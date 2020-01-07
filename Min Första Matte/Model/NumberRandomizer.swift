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
    
    
    func numberRandomizer(startNumber: Int, endNumber: Int, condition: (Int, Int) -> Bool) -> (Int, Int) {
         
        var firstNumber: Int
        var secondNumber: Int
        
        repeat {
            firstNumber = Int.random(in: startNumber...endNumber)
            secondNumber = Int.random(in: startNumber...endNumber)
        } while condition(firstNumber, secondNumber) || (firstNumber + secondNumber == previousResult)
        
        previousResult = firstNumber + secondNumber
        //print("Prev \(previousResult)")
        
        return (firstNumber, secondNumber)
    }
    
    
    
    
    let additionCondition: (Int, Int) -> Bool = { (firstNumber: Int, secondNumber: Int) -> Bool in
        return firstNumber + secondNumber > 5
    }
    
    let additionMedContidion: (Int, Int) -> Bool = { (firstNumber: Int, secondNumber: Int) -> Bool in
        return firstNumber + secondNumber < 6 || firstNumber + secondNumber > 10
    }
    
    let subtractionCondition: (Int, Int) -> Bool = { (firstNumber: Int, secondNumber: Int) -> Bool in
        return firstNumber - secondNumber < 0
    }
    
    
    
    func numberRandomizerHard() {
        
    }
    
    
    
    
    
    
    
    /*let randomSubtractionNumbers: () -> (Int, Int) = {
        return f - s < 0
    }
    
    let randomAdditionNumber: () -> (Int, Int) = {
        
    }*/
    
}
