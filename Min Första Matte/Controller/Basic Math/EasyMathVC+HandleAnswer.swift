//
//  EasyMathVC+HandleAnswer.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-01-07.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

extension EasyMathVC {
    
    
    
     func getCurrentEquationCardNumbers() -> [Int] {
         
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
    
    
    // Check if dragged card is the correct one
    func validateChosenAnswer(currentView: UIView, answerView: UIView) {
        
        guard let calculator = calculator else { return } // Unwrap instance of calculator
        
        UIView.animate(withDuration: 0.2) {
            currentView.center = answerView.center // Position the draggedCard in the answerView
        }
        
        let equationNumbers = getNumbersInEquation(currentView: currentView)
        
        //let chosenNumber = playableCards[currentView.tag - 1].number // Dragged card's number
        //let equationNumbers = getCurrentEquationCardNumbers()
        
        //print("ChosenNumber: \(chosenNumber)")
        //print("First \(equationNumbers[0]), sec. \(equationNumbers[1])")

//        let indexForAnswerView = getAnswerViewPosition()
//
//        var firstNumb: Int = 0
//        var secondNumb: Int = 0
//        var resultNumb: Int = 0
//
//        switch indexForAnswerView {
//        case 0:
//            firstNumb = chosenNumber
//            secondNumb = equationNumbers[0]
//            resultNumb = equationNumbers[1]
//        case 1:
//            firstNumb = equationNumbers[0]
//            secondNumb = chosenNumber
//            resultNumb = equationNumbers[1]
//        case 2:
//            firstNumb = equationNumbers[0]
//            secondNumb = equationNumbers[1]
//            resultNumb = chosenNumber
//        default:
//            break
//        }
        
        // TODO: FIX calcMode: calcualtor.addition
        
        if calculator.validateMathResult(calcMode: calculator.addition, firstNumb: equationNumbers.firstNumber, secondNumb: equationNumbers.secondNumber, resultNumb: equationNumbers.resultNumber) {
        //if calculator.validateMathResult(calcMode: calculator.addition, firstNumb: firstNumb, secondNumb: secondNumb, resultNumb: resultNumb) {
            handleAnswer(answerCorrect: true) // Correct Answer
        } else {
            handleAnswer(answerCorrect: false) // Incorrect Answer
        }
    }
    
    
    func getNumbersInEquation(currentView: UIView) -> (firstNumber: Int, secondNumber: Int, resultNumber: Int) {
        
        let chosenNumber = playableCards[currentView.tag - 1].number // Dragged card's number
        let equationNumbers = getCurrentEquationCardNumbers()
        let answerIndexPosition = getAnswerViewPosition()

        switch answerIndexPosition {
        case 0:
            return (chosenNumber, equationNumbers[0], equationNumbers[1])
        case 1:
            return (equationNumbers[0], chosenNumber, equationNumbers[1])
        case 2:
            return (equationNumbers[0], equationNumbers[1], chosenNumber)
        default:
            return (0, 0, 0) // TODO: FIX!
        }
    }
    
    
    
    
    func getCalculationMode() {
        
        
        
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
         //disableOrEnableCardInteractions(shouldDisable: false) // Enable moving/turning cards again
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
        score += 25
        print("Score: \(score)")
        //scoreLabel.text = "\(score)"
    }
    
    
    
    
    func answerIsIncorrect() {
                
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75) {
            self.resetToCardPosition() // FIX ONLY RESET CURRENT CARD
            self.changeAnswerViewImage(displayWrongAnswer: true)
            //self.WrongImage.isHidden = false // TODO: ändra bild bara
            self.disableOrEnableCardInteractions(shouldDisable: false)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.changeAnswerViewImage(displayWrongAnswer: false)
                //self.WrongImage.isHidden = true
            }
        }
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            //self.scoreLabel.text = "Score: \(self.score)"
        }
        
    }
}


