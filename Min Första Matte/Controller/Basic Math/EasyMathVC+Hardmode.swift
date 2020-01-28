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
           refillProgress()
           createTimeInterval()
       }
    
    
    @objc func progressBarSlowDecrease() {
         
         progressBarWidth.constant = EasyMathVC.decreaseProgress(progressBarWidth.constant, progressBarContainer.frame.width, 0.05)
         //        progressBarWidth.constant = EasyMathVC.slowDecreaseProgress(progressBarWidth.constant, progressBarContainer.frame.width, 0.1) // 5 for smoother but harder to check for 0
         
         UIView.animate(withDuration: 1) {
             self.view.layoutIfNeeded()
         }
         
         checkForNoProgressBar()
     }
     
     // TODO: STOP TIMER, put Timer in the top var timer: Timer?
     func createTimeInterval() {
         let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(progressBarSlowDecrease), userInfo: nil, repeats: true)
     }
    
    
    func decreaseDifficulty() {
          currentDifficulty = updateDifficulty(difficulty: currentDifficulty.rawValue - 1)
          setupNextEquation()
          setPlayableCardsNumber()
          newCardTransitionFlip(cardViews: playableCardViews)
          setCardImages(cards: playableCards, cardImages: playableCardImages)
          returnCardViewsToOriginalPosition()
          refillProgress()
      }
      
      
      func checkForNoProgressBar() {
          
          if progressBarWidth.constant.rounded() <= 0 && currentDifficulty.rawValue > 1 {
              decreaseDifficulty()
          }
      }
}
