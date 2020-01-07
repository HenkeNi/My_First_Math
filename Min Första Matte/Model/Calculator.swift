//
//  CalculatorBrain.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-05-21.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

// TODO: add case memoryGame??
enum CalculationMode: String {
    case addition = "Addition"
    case subtraction = "Subtraction"
    //case multiplication = "Multiplication"
    //case division = "Division"
    
    //case memoryCard
}

class Calculator {
    
    // Old versuib
    func calculate(mode : CalculationMode, numb1: Int, numb2: Int, chosenNumb: Int) -> Bool {
        
        var answer: Bool
        
        switch mode {
        case .addition:
            answer = chosenNumb == numb1 + numb2 ? true : false
        case .subtraction:
            answer = chosenNumb == numb1 - numb2 ? true : false
        }
        
        return answer
    }
    
    
    
    // New version
        
    // How to use
    // validateMathResult(calcMode: addition, numb1: 3, numb2: 2, answerNumb: 5) // true

    
    // ValidateMathResult checks if the two given numbers are equal to the answer, with calcMode deciding how it should be calculated
    func validateMathResult(calcMode: (Int, Int) -> Int, firstNumb: Int, secondNumb: Int, resultNumb: Int) -> Bool {
            return calcMode(firstNumb, secondNumb) == resultNumb
    }
    

    // Using closures instead
    let addition: (Int, Int) -> Int = {
        return $0 + $1
    }
    let subtraction: (Int, Int) -> Int = {
        return $0 - $1
    }
    let division: (Int, Int) -> Int = {
        return $0 / $1
    }
    let multiplication: (Int, Int) -> Int = {
        return $0 * $1
    }
    
    // Old way
    /*func multiplication(numb1: Int, numb2: Int) -> Int {
        return numb1 * numb2
    }
    
    func addition(numb1: Int, numb2: Int) -> Int {
        return numb1 + numb2
    }
    
    func subtraction(numb1: Int, numb2: Int) -> Int {
        return numb1 - numb2
    }
    
    func division(numb1: Int, numb2: Int) -> Int {
        return numb1 / numb2
    }*/
    
    
    
    
    // Other New Version (opposite)
    func chooseCalculationMode(isAddition: Bool) -> (Int, Int, Int) -> Bool {
        return isAddition ? additionMode : subtractionMode
    }
    
    
    // Using closures
    var additionMode: (Int, Int, Int) -> Bool = {
        return $2 == $0 + $1
    }
    
    var subtractionMode: (Int, Int, Int) -> Bool = {
        return $2 == $0 - $1
    }
    
    /*
    func additionMode(numb1: Int, numb2: Int, answer: Int) -> Bool {
        return answer == numb1 + numb2
    }
    
    func subtractionMode(numb1: Int, numb2: Int, answer: Int) -> Bool {
        return answer == numb1 - numb2
    }
    */
    
   
    
    
    
    
    
    
    
    // Generic version
//    func genericCalculator<T: Equatable>(firstNumb: T, secondNumb: T, chosenAnswer: T) -> Bool {
//
//        //return firstNumb + secondNumb == chosenAnswer
//
//    }
    
    
    
    
}
