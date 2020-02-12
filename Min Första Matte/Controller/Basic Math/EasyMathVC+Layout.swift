//
//  EasyMathVC+Layout.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-27.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

// RENAME: EasyMathVC+UI instead?
// ELLER +UpdateUI

extension EasyMathVC {
    
    
    // Returns closure expression for updating progressbar
     func updateProgressBar(isRightAnswer: Bool) -> (CGFloat, CGFloat, CGFloat) -> CGFloat {
        return isRightAnswer ? EasyMathVC.increaseProgress : EasyMathVC.decreaseProgress
     }
     
     // Closure expression for increasing progressbar
    static let increaseProgress = { (barWidth: CGFloat, containerWidth: CGFloat, increaseAmount: CGFloat) -> CGFloat in
           
        return barWidth >= containerWidth ? containerWidth : barWidth + (containerWidth * increaseAmount)
     }
         
     // Closure expression for decreasing progressbar
    static let decreaseProgress = { (barWidth: CGFloat, containerWidth: CGFloat, decreaseAmount: CGFloat) -> CGFloat in
         
         return barWidth < 0 ? 0.0 : barWidth - (containerWidth * decreaseAmount)
     }
     
    func refillHalfProgress() {
        progressBarWidth.constant = progressBarContainer.frame.width / 2
      
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    //        progressBarWidth.constant = EasyMathVC.fullProgress(progressBarWidth.constant, progressBarContainer.frame.width)
    }
    
    func resetProgress() {
        progressBarWidth.constant = 0
    }

    
//    static let resetProgress: (CGFloat, CGFloat) -> CGFloat = { (barWidth: CGFloat, containerWidth: CGFloat) -> CGFloat in
//        return 0
//    }
//
//    static let fullProgress: (CGFloat, CGFloat) -> CGFloat = { (barWidth: CGFloat, containerWidth: CGFloat) -> CGFloat in
//        return containerWidth
//    }
    
    
    
    func updateScoreLabel() {
        scoreLabel.text = "Score: \(score)"
    }

    // TOOD: Set nil/Black om card.isAnswerView = true?
    func setCardImages(cards: [MathCard], cardImages: [UIImageView]) {
        
        for (index, cardImage) in cardImages.enumerated() where cardImage.tag == index + 1 {
            cardImage.image = UIImage(named: cards[index].getImageName)
        }
    }
    
    
     // TEST; lade till where !cards[index].isAnserView
    func setCardLabels(cards: [MathCard], cardLabels: [UILabel]) {
        
        for (index, label) in cardLabels.enumerated() where !cards[index].isAnswerView {
            label.text = cards[index].labelText
        }
    }
    
    
    // Rounded corners, border width (and color) for Cards
    func customizeCards(cardViews: [UIView]) {
        
        cardViews.map { $0.roundedCorners(myRadius: 20, borderWith: 5, myColor: .darkGray) }
    
    }
    
    
    // Change between question mark and x (wrong answer)
     // rename: toogleAnswerViewImgOrWrongImg
     func changeAnswerViewImage(displayWrongAnswer: Bool) {
                 
         for (index, image) in equationCardImages.enumerated() where index == getAnswerViewIndex() {
             image.image = displayWrongAnswer ? UIImage(named: "WrongAnswer") : UIImage(named: "NumberQuestion")
         }
     }
    

    func setOperatorImages(mathMode: CalculationMode) {
                
        switch mathMode {
        case .addition:
            operatorCardImages[0].image = UIImage(named: "NumberPlus")
            operatorCardImages[1].image = UIImage(named: "NumberEqual")
        case .subtraction:
            operatorCardImages[0].image = UIImage(named: "NumberMinus")
            operatorCardImages[1].image = UIImage(named: "NumberEqualMinus")
        case .multiplication:
            operatorCardImages[0].image = UIImage(named: "NumberMulti")
            operatorCardImages[1].image = UIImage(named: "NumberEqual")
        }
    }

    
    // Sets right background color based on CalculationMode
    func setBackgroundColors(mathMode: CalculationMode) {
           
        view.backgroundColor = mathMode == .addition ? .additionLightBrown : .subtractionLightBlue
        topView.backgroundColor = mathMode == .addition ? .additionBrown : .subtractionBlue
        progressBarViewBackground.backgroundColor = mathMode == .addition ? .additionBrown : .subtractionBlue
    }
    
    
    func setProgressBarColor(isRightAnswer: Bool) {
        progressBarView.backgroundColor = isRightAnswer ? .progressBarColor : .progressBarFailColor
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.progressBarView.backgroundColor = UIColor.progressBarColor
        }
    }
       
    
    
}






















