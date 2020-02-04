//
//  EasyMathVC+Hardmode.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-01-26.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

extension EasyMathVC {
    
    
    // enableHardmode
       func setupHardmodeConfigurations() {
           refillHalfProgress()
           createTimeInterval()
           timerLabel.isHidden = false
       }
    
    
    @objc func progressBarSlowDecrease() {
         
        let decreaseSpeed: CGFloat = CGFloat(currentDifficulty.rawValue) * 0.025
        print("dec speed \(decreaseSpeed)")
        progressBarWidth.constant = EasyMathVC.decreaseProgress(progressBarWidth.constant, progressBarContainer.frame.width, decreaseSpeed)
         //        progressBarWidth.constant = EasyMathVC.slowDecreaseProgress(progressBarWidth.constant, progressBarContainer.frame.width, 0.1) // 5 for smoother but harder to check for 0
         
         UIView.animate(withDuration: 1) {
             self.view.layoutIfNeeded()
         }
         
         checkForNoProgressBar()
     }
     
     // TODO: STOP TIMER, put Timer in the top var timer: Timer?
     func createTimeInterval() {
        
        var timeLeft = 12
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            timer.tolerance = 0.2
            timeLeft > 0 ? timeLeft -= 1 : timer.invalidate()
            self.timerLabel.text = "\(timeLeft)"
            self.progressBarSlowDecrease()
            print("Time is \(timeLeft)")
            
            if timeLeft <= 0 { self.endOfTime() }
        })
         //let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(progressBarSlowDecrease), userInfo: nil, repeats: true)
     }
    
    func endOfTime() {
        //alert
        print("Your score was \(score)")
    }
    
    
    func decreaseDifficulty() {
          currentDifficulty = updateDifficulty(difficulty: currentDifficulty.rawValue - 1)
          //setupNextEquation()
          updateAnswerView()
          updateEquationCards()
          updatePlayableCards()
          //setPlayableCardsNumber()
          newCardTransitionFlip(cardViews: playableCardViews)
        
        if let playableCards = playableCards?.cards {
            setCardImages(cards: playableCards, cardImages: playableCardImages)
        }
          returnCardViewsToOriginalPosition()
          refillHalfProgress()
      }
      
      
      func checkForNoProgressBar() {
          
          if progressBarWidth.constant.rounded() <= 0 && currentDifficulty.rawValue > 1 {
              decreaseDifficulty()
          }
      }
}
