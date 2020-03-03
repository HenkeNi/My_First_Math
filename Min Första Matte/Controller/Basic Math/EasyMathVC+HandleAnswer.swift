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

        guard let playableCards = playableCards, let equationCards = equationCards, let index = equationCards.answerViewIndex else { return }

        placeCardInAnswerView(currentView: currentView, answerView: answerView)

        // If dragged card (number) is the same as equation card (answerView/number)
        handleAnswer(answerCorrect:  playableCards[currentView.tag - 1].number == equationCards[index].number)
    }

    
    
    
    
    func handleAnswer(answerCorrect: Bool) {
         
        disableCardInteractions(views: playableCardViews, shouldDisable: true)
        disableCardInteractions(views: equationCardViews, shouldDisable: true)
         
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
            self.returnCards() // FIX ONLY RESET CURRENT CARD
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
                soundManager?.playSound(soundName: "Cheering")

                 //playSound(soundName: "Cheering")
                hardModeEnabled ? refillHalfProgress() : resetProgress()
             }
         }
     
//         currentDifficulty = updateDifficulty(difficulty: difficultyValue)
     }
    
    

    
    
    // COMBINE SCORE FUNCTIONS 
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
    
    
    func placeCardInAnswerView(currentView: UIView, answerView: UIView) {
        
        soundManager?.playSound(soundName: "Click")
        
        //playSound(soundName: "Click")
               
        UIView.animate(withDuration: 0.2) {
            currentView.center = answerView.center // Position the draggedCard in the answerView
        }
    }
    
    
    
}








    
