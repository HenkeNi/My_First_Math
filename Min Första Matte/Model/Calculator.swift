//
//  CalculatorBrain.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-05-21.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

enum CalculationMode: String {
    case addition = "Addition"
    case subtraction = "Subtraction"
    case multiplication = "Multiplication"
    //case division = "Division"
    
}

class Calculator {
    
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
    


      
    
    
    
    
    
    
    // Generic version
//    func genericCalculator<T: Equatable>(firstNumb: T, secondNumb: T, chosenAnswer: T) -> Bool {
//
//        //return firstNumb + secondNumb == chosenAnswer
//
//    }
    
    
    
    
}
