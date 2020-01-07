//
//  EasyMathVC+HandleAnswer.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-01-07.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

extension EasyMathVC {
    
    
    
    static let basicAdditionAnswerCondition: (Int, Int, Int) -> Bool = {
        return $0 + $1 == $2
    }
    
    static let hardAdditionAnswerConitdion: (Int, Int, Int) -> Bool = {
        return $2 - $0 == $1
    }
    
    func calcAnswer(chosenNumb: Int, firstNumb: Int, answerNumb: Int) -> Bool {
         print("\(firstNumb) + \(chosenNumb) == \(answerNumb)")
         return firstNumb + chosenNumb == answerNumb
     }
     
    
    
     func getEquationNumbers() -> [Int] {
         
         var array = [Int]()
         
         for card in equationCards where !card.isAnswerView {
             array.append(card.number)
         }
         return array
     }
    
    
    func getAnswerViewPosition() -> Int? {
        for (index, card) in equationCards.enumerated() where card.isAnswerView {
            return index
        }
        return nil
    }
    
    
    
//    func validateChosenAnswer(currentView: UIView, answerView: UIView) {
//
//
//         UIView.animate(withDuration: 0.2) {
//             currentView.center = answerView.center // Position the draggedCard in the answerView
//         }
//
//         let chosenNumber = playableCards[currentView.tag - 1].number // Dragged card's number
//         print("ChosenNumber: \(chosenNumber)")
//
//         let equationNumbers = getEquationNumbers()
//         print("First \(equationNumbers[0]), sec. \(equationNumbers[1])")
//
//         // TODO: FIX calcMode: calcualtor.addition
//         // TODO: kolla vilka som är nummer och vilket som är answerView!!!
//         if calcAnswer(chosenNumb: chosenNumber, firstNumb: equationNumbers[0], answerNumb: equationNumbers[1]) {
//
//             handleAnswer(answerCorrect: true) // Correct Answer
//         } else {
//             handleAnswer(answerCorrect: false) // Incorrect Answer
//         }
//     }
    
    
    
    
    // Check if dragged card is the correct one
    func validateChosenAnswer(currentView: UIView, answerView: UIView) {
        
        guard let calculator = calculator else { return } // Unwrap instance of calculator
        
        UIView.animate(withDuration: 0.2) {
            currentView.center = answerView.center // Position the draggedCard in the answerView
        }
        
        let chosenNumber = playableCards[currentView.tag - 1].number // Dragged card's number
        let equationNumbers = getEquationNumbers()
        
        print("ChosenNumber: \(chosenNumber)")
        print("First \(equationNumbers[0]), sec. \(equationNumbers[1])")

        let indexForAnswerView = getAnswerViewPosition()
        
        var firstNumb: Int = 0
        var secondNumb: Int = 0
        var resultNumb: Int = 0
        
        switch indexForAnswerView {
        case 0:
            firstNumb = chosenNumber
            secondNumb = equationNumbers[0]
            resultNumb = equationNumbers[1]
        case 1:
            firstNumb = equationNumbers[0]
            secondNumb = chosenNumber
            resultNumb = equationNumbers[1]
        case 2:
            firstNumb = equationNumbers[0]
            secondNumb = equationNumbers[1]
            resultNumb = chosenNumber
        default:
            break
        }
        
        // TODO: FIX calcMode: calcualtor.addition
        // TODO: kolla vilka som är nummer och vilket som är answerView!!!
        if calculator.validateMathResult(calcMode: calculator.addition, firstNumb: firstNumb, secondNumb: secondNumb, resultNumb: resultNumb) {
            
            handleAnswer(answerCorrect: true) // Correct Answer
        } else {
            handleAnswer(answerCorrect: false) // Incorrect Answer
        }
    }
    
    
    
    func handleAnswer(answerCorrect: Bool) {
         
         disableOrEnableCardInteractions(shouldDisable: true)
         
         
         answerCorrect ? answerIsCorrect() : answerIsIncorrect()
         let progressBarUpdate = updateProgressBar(isRightAnswer: answerCorrect)
         
         progressBarWidth.constant = progressBarUpdate(progressBarWidth.constant, progressBarContainer.frame.size.width)
         
         checkProgress()
         
         UIView.animate(withDuration: 1) {
             self.view.layoutIfNeeded()
             //self.scoreLabel.text = "Score: \(self.score)"
         }
         disableOrEnableCardInteractions(shouldDisable: false) // Enable moving/turning cards again
     }
    
    
    
    
    
    func answerIsCorrect() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            AlertView.instance.showAlert(title: "Correct!", message: "That is the right number!", alertType: .success)
        }
        
        //let updateProgress = updateProgressBar(isRightAnswer: true) // Sets update to be of type increaseProgress
        //progressBarWidth.constant = updateProgress(progressBarWidth.constant, progressBarContainer.frame.size.width)
        
        //updateScore()
        
        //originalCardPositions() // TEST
        //nextLevel()
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            //self.scoreLabel.text = "Score: \(self.score)"
        }
        
    }
    
    
    
    
    func answerIsIncorrect() {
                
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75) {
            self.resetToCardPosition()
            //self.WrongImage.isHidden = false // TODO: ändra bild bara
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                //self.WrongImage.isHidden = true
            }
        }
        
        //nextLevel()
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            //self.scoreLabel.text = "Score: \(self.score)"
        }
        
    }
}


