//
//  EasyMathVC+HandleAnswer.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-01-07.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

extension EasyMathVC {
    
  
    
    
 
    
    
    // Check if dragged card is the correct one
    func validateChosenAnswer(currentView: UIView, answerView: UIView) {
               
        guard let calculator = calculator, let playableCards = playableCards?.cards else { return }

        UIView.animate(withDuration: 0.2) {
            currentView.center = answerView.center // Position the draggedCard in the answerView
        }
        
        let calculationMode = getCalculationMode(calc: calculator)
        let equationNumbers = getNumbersInEquation(chosenNumber: playableCards[currentView.tag - 1].number)
            
        if calculator.validateMathResult(calcMode: calculationMode, firstNumb: equationNumbers.firstNumber, secondNumb: equationNumbers.secondNumber, resultNumb: equationNumbers.resultNumber) {
            handleAnswer(answerCorrect: true) // Correct Answer
        } else {
            handleAnswer(answerCorrect: false) // Incorrect Answer
        }
    }
    
    
    
       func getNumbersInEquation(chosenNumber: Int) -> (firstNumber: Int, secondNumber: Int, resultNumber: Int) {
           
           let equationNumbers = getCurrentEquationCardNumbers()

           switch getAnswerViewIndex() {
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
       
       func getCurrentEquationCardNumbers() -> [Int] {
              
           var equationsNumbers = [Int]()
              
            if let equationCards = equationCards?.cards {
                for card in equationCards where !card.isAnswerView {
                    equationsNumbers.append(card.number)
                }
            }
           return equationsNumbers
       }

    

    func getCalculationMode(calc: Calculator) -> (Int, Int) -> Int {
        
        //guard let calculator = calculator else { return } // Unwrap instance of calculator
        
        switch mathMode {
        case .addition:
            return calc.addition
        case .subtraction:
            return calc.subtraction
        case .multiplication:
            return calc.multiplication
        }
        
    }
    
    
    func handleAnswer(answerCorrect: Bool) {
         
         disableCardInteractions(shouldDisable: true)
         
         
        answerCorrect ? answerIsCorrect() : answerIsIncorrect()
         let progressBarUpdate = updateProgressBar(isRightAnswer: answerCorrect)
        setProgressBarColor(isRightAnswer: answerCorrect)
        
        progressBarWidth.constant = progressBarUpdate(progressBarWidth.constant, progressBarContainer.frame.size.width, 0.5)
         
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
        //score += 25
        updateNormalScore()
        print("Score: \(score)")
        //scoreLabel.text = "\(score)"
    }
    
    
    
    
    func answerIsIncorrect() {
                
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75) {
            self.returnCardViewsToOriginalPosition() // FIX ONLY RESET CURRENT CARD
            self.changeAnswerViewImage(displayWrongAnswer: true)
            //self.WrongImage.isHidden = false // TODO: ändra bild bara
            self.disableCardInteractions(shouldDisable: false)
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
    
    
    // TODO: SPlit in two functions??
     func checkProgress() {
         var difficultyValue = currentDifficulty.rawValue
         
         if progressBarWidth.constant.rounded() == progressBarContainer.frame.size.width.rounded() {
             
             if difficultyValue < Difficulty.allCases.count {
                 // Increase lvl!
                 difficultyValue += 1
                 playSound(soundName: "Cheering")
                 progressBarWidth.constant = 0
             }
         }
     
         currentDifficulty = updateDifficulty(difficulty: difficultyValue)
     }
    
    
//      func increaseDifficulty() {
//
//      }
    
    func updateNormalScore() {
        
        switch currentDifficulty {
        case .easy:
            score += 5
        case .medium:
            score += 10
        case .hard:
            score += 15
        case .veryHard:
            score += 20
        case .impossible:
            score += 25
        }
    }
    
    func updateHardmodeScore() {
        
    }
}


