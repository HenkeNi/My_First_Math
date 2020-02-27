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

        playSound(soundName: "Click")
        
        UIView.animate(withDuration: 0.2) {
            currentView.center = answerView.center // Position the draggedCard in the answerView
        }
        
        let calculationMode = getCalculationMode(calc: calculator)
        let equationNumbers = getNumbersInEquation(chosenNumber: playableCards[currentView.tag - 1].number)
        
        handleAnswer(answerCorrect: calculator.validateMathResult(firstNumb: equationNumbers.firstNumber, secondNumb: equationNumbers.secondNumber, resultNumb: equationNumbers.resultNumber, calcMode: calculationMode))
        
//        if calculator.validateMathResult(firstNumb: equationNumbers.firstNumber, secondNumb: equationNumbers.secondNumber, resultNumb: equationNumbers.resultNumber, calcMode: calculationMode) {
//
//            handleAnswer(answerCorrect: true) // Correct Answer
//        } else {
//            handleAnswer(answerCorrect: false) // Incorrect Answer
//        }
    }
    
    
    
       func getNumbersInEquation(chosenNumber: Int) -> (firstNumber: Int, secondNumber: Int, resultNumber: Int) {
           
        guard let equationNumbers = getCurrentEquationCardNumbers(), let answerViewIndex = equationCards?.answerViewIndex else { return (0, 0, 0) }

           switch answerViewIndex {
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
       
    
        // Returns numbers in equationCards that are not 'isAnswerView'
       func getCurrentEquationCardNumbers() -> [Int]? {

            if let equationCards = equationCards?.cards {
                
                return equationCards.filter { !$0.isAnswerView }.map { $0.number }
            }
            return nil
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
         
        disableCardInteractions(views: playableCardViews, shouldDisable: true)
         
//        if hardModeEnabled {
//
//        } else {
//
//        }
        answerCorrect ? answerIsCorrect() : answerIsIncorrect()
        
         let progressBarUpdate = updateProgressBar(isRightAnswer: answerCorrect)
        setProgressBarColor(isRightAnswer: answerCorrect)
        
        progressBarWidth.constant = progressBarUpdate(progressBarWidth.constant, progressBarContainer.frame.size.width, 0.25)
         
         checkProgress()
        
        //hardModeEnabled ? updateHardmodeScore(isCorrectAnswer: answerCorrect) : updateNormalScore()
         
         UIView.animate(withDuration: 1) {
             self.view.layoutIfNeeded()
             //self.scoreLabel.text = "Score: \(self.score)"
         }
         //disableOrEnableCardInteractions(shouldDisable: false) // Enable moving/turning cards again
     }
    
    
//    func getProgressBarUpdateAmount() {
//
//    }
    
    
    
    func answerIsCorrect() {
        
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            self.hardModeEnabled ? self.updateNextLevel() : AlertView.instance.showAlert(title: "Correct!", message: "That is the rigth number!!", alertType: .success)
        }
    
        
        //let updateProgress = updateProgressBar(isRightAnswer: true) // Sets update to be of type increaseProgress
        //progressBarWidth.constant = updateProgress(progressBarWidth.constant, progressBarContainer.frame.size.width)
        
        //updateScore()
        
        //originalCardPositions() // TEST
        //nextLevel()
        
//        UIView.animate(withDuration: 1) {
//            self.view.layoutIfNeeded()
//            //self.scoreLabel.text = "Score: \(self.score)"
//        }
        //score += 25
        //updateNormalScore()
        print("Score: \(score)")
        //scoreLabel.text = "\(score)"
    }
    
    
//    func answerIsIncorrect() {
//        perform(#selector(answerIsIncorrect2), with: nil, afterDelay: 0.75)
//    }
    
    @objc func answerIsIncorrect() {
        
        let serialQueue = DispatchQueue(label: "customQueue")
        
        serialQueue.asyncAfter(deadline: DispatchTime.now() + 0.75) {
            
        //DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now() + 0.75) {
            
            DispatchQueue.main.async {
                
        //DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75) {
            self.returnCardViewsToOriginalPosition() // FIX ONLY RESET CURRENT CARD
            self.changeAnswerViewImage(displayWrongAnswer: true)
                self.disableCardInteractions(views: self.playableCardViews, shouldDisable: false)
            
//                let serial2Queue = DispatchQueue(label: "otherCustomQueue")
//                serial2Queue.asyncAfter(deadline: DispatchTime.now() + 1) {
//
//                    DispatchQueue.main.async {
//                        self.changeAnswerViewImage(displayWrongAnswer: false)
//                    }
//                }
                
            //DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                //DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now() + 1) {
                    
                  //  DispatchQueue.main.async {
                        //self.changeAnswerViewImage(displayWrongAnswer: false)
                    //}
           // }
            }
        }
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            //self.scoreLabel.text = "Score: \(self.score)"
        }
    
    }
    
   
    
    // TODO : FIX difficulty increase (remove function?)
    // TODO: SPlit in two functions??
     func checkProgress() {
        // var difficultyValue = currentDifficulty.rawValue
         
         if progressBarWidth.constant.rounded() == progressBarContainer.frame.size.width.rounded() {
             
            if currentDifficulty.rawValue < Difficulty.allCases.count {
                 // Increase lvl!
                 //difficultyValue += 1
                currentDifficulty = updateDifficulty(difficulty: currentDifficulty.rawValue + 1)
                 playSound(soundName: "Cheering")
                hardModeEnabled ? refillHalfProgress() : resetProgress()
             }
         }
     
//         currentDifficulty = updateDifficulty(difficulty: difficultyValue)
     }
    
    
//      func increaseDifficulty() {
//
//      }
    
    func updateNormalScore() {
        
        
        score += currentDifficulty.rawValue * 5
    
    }
    
    func updateHardmodeScore(isCorrectAnswer: Bool) {
        
        if isCorrectAnswer {
            score += currentDifficulty.rawValue * 5
        } else {
            score -= currentDifficulty.rawValue * 2
        }
    }
}


