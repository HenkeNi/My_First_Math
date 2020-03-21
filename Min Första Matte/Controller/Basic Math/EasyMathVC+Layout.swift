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
    
    
    
    
//    func updateScoreLabel() {
//        scoreLabel.text = "Score: \(score)"
//    }

    
    
    // TOOD: Set nil/Black om card.isAnswerView = true?
    func setCardImages<T: Card>(cards: [T], cardImages: [UIImageView]) {

        sortOutletCollections()
    
        for (index, cardImage) in cardImages.enumerated() where cardImage.tag == index + 1 {
            cardImage.image = UIImage(named: cards[index].imageName)
        }
    }
    
    
     // TEST; lade till where !cards[index].isAnserView
    func setCardLabels<T: Card>(cards: [T], cardLabels: [UILabel]) {
        
        for (index, label) in cardLabels.enumerated() {
                   label.text = cards[index].labelText
        }
        
//        for (index, label) in cardLabels.enumerated() where !cards[index].isAnswerView {
//            label.text = cards[index].labelText
//        }
        
    }
    
        
    
    
    // Change between question mark and x (wrong answer)
     // rename: toogleAnswerViewImgOrWrongImg
    func changeAnswerViewImage(displayWrongAnswer: Bool) {

        guard let index = equationCards?.answerViewIndex else { return }
            
            let answerViewImage = equationCardImages[index]
            
            if displayWrongAnswer {
                answerViewImage.image = UIImage(named: "WrongAnswer")

                DispatchQueue(label: "serial").asyncAfter(deadline: DispatchTime.now() + 1.0) {
                    DispatchQueue.main.async {
                        answerViewImage.image = UIImage(named: "NumberQuestion")
                    }
                }
            } else {
                answerViewImage.image = UIImage(named: "NumberQuestion")
            }
            
        
     }


    
    // RENAME IMAges   "NumberMultiplication"  Number\(mathMode.rawValue)
    func setOperatorImages(mathMode: CalculationMode) {
                
        switch mathMode {
        case .addition:
            operatorCardImages[0].image = UIImage(named: "NumberPlus")
        case .subtraction:
            operatorCardImages[0].image = UIImage(named: "NumberMinus")
        case .multiplication:
            operatorCardImages[0].image = UIImage(named: "NumberMulti")
        case .division:
            operatorCardImages[0].image = UIImage(named: "OkCheck")
        }
        operatorCardImages[1].image = UIImage(named: "NumberEqual")

    }

    

    
    
    func setProgressBarColor(isRightAnswer: Bool) {
        progressBarView.backgroundColor = isRightAnswer ? .progressBarColor : .progressBarFailColor
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.progressBarView.backgroundColor = UIColor.progressBarColor
        }
    }
       
    
    
}


















//
//    func setCardImages(cards: [MathCard], cardImages: [UIImageView]) {
//
//        sortOutletCollections()
//
//        for (index, cardImage) in cardImages.enumerated() where cardImage.tag == index + 1 {
//            cardImage.image = UIImage(named: cards[index].imageName)
//        }
//    }
//
//
//     // TEST; lade till where !cards[index].isAnserView
//    func setCardLabels(cards: [MathCard], cardLabels: [UILabel]) {
//
//        for (index, label) in cardLabels.enumerated() {
//                   label.text = cards[index].labelText
//        }
//
////        for (index, label) in cardLabels.enumerated() where !cards[index].isAnswerView {
////            label.text = cards[index].labelText
////        }
//
//    }


