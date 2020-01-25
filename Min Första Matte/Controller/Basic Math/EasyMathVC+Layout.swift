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
    
    
    // OBS: gjorde closuresen statiska samt lade till EasyMathVC. funktitonene!!!
    
    
    // Returns closure expression for updating progressbar
     func updateProgressBar(isRightAnswer: Bool) -> (CGFloat, CGFloat) -> CGFloat {
        return isRightAnswer ? EasyMathVC.increaseProgress : EasyMathVC.decreaseProgress
     }
     
     // Closure expression for increasing progressbar
     static let increaseProgress: (CGFloat, CGFloat) -> CGFloat = { (barWidth: CGFloat, containerWidth: CGFloat) -> CGFloat in
           
        return barWidth >= containerWidth ? containerWidth : barWidth + (containerWidth * 0.5)
        //return barWidth >= containerWidth ? containerWidth : barWidth + (containerWidth * 0.1)
     }
     
     // Closure expression for decreasing progressbar
     static let decreaseProgress: (CGFloat, CGFloat) -> CGFloat = { (barWidth: CGFloat, containerWidth: CGFloat) -> CGFloat in
         
         return barWidth < 0 ? 0.0 : barWidth - (containerWidth * 0.1)
     }
     
//    static let decreaseProgress: (CGFloat) -> CGFloat = {
//        return barWidth < 0 ? 0.0 : 
//    }
    
    
    // TODO COMBINE SLOW DECREASE WITH DECrease
    
    // FIXA
    static let resetProgress: (CGFloat, CGFloat) -> CGFloat = { (barWidth: CGFloat, containerWidth: CGFloat) -> CGFloat in
        return 0
    }
    
    
    static let fullProgress: (CGFloat, CGFloat) -> CGFloat = { (barWidth: CGFloat, containerWidth: CGFloat) -> CGFloat in
        return containerWidth
    }
    
    // COmbine with decreaseProgress (input for amount to decrease with)
    static let slowDecreaseProgress: (CGFloat, CGFloat, CGFloat) -> CGFloat = { (barWidth: CGFloat, containerWidth: CGFloat, decreaseBy: CGFloat) -> CGFloat in
        return barWidth < 0 ? 0.0 : barWidth - (containerWidth * decreaseBy)
        
    }
    
    

    // TOOD: Set nil/Black om card.isAnswerView = true?
    func setCardImages(cards: [MathCard], cardImages: [UIImageView]) {
        
        for (index, cardImage) in cardImages.enumerated() where cardImage.tag == index + 1 {
            //cardImage.image = UIImage(named: cards[index].imageName)
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
           
        for cardView in cardViews {
            cardView.roundedCorners(myRadius: 20, borderWith: 5, myColor: .darkGray)
        }
    }
    
    
    
    
    // TODO: RENAME IMAGES
    func setOperatorImages(mathMode: CalculationMode) {
        
        var operatorImgName: String
        
        switch mathMode {
        case .addition:
            //operatorImgName = "NumberPlus"
            operatorCardImages[0].image = UIImage(named: "NumberPlus")
            operatorCardImages[1].image = UIImage(named: "NumberEqual")
        case .subtraction:
            //operatorImgName = "NumberMinus"
            operatorCardImages[0].image = UIImage(named: "NumberMinus")
            operatorCardImages[1].image = UIImage(named: "NumberEqualMinus")
        case .multiplication:
            //operatorImgName = "NumberMulti"
            operatorCardImages[0].image = UIImage(named: "NumberMulti")
            operatorCardImages[1].image = UIImage(named: "NumberEqual")
        }
        //operatorCardImages[0].image = UIImage(named: operatorImgName)
    }

    
    // Sets right background color based on CalculationMode
    func setBackgroundColors(mathMode: CalculationMode) {
           
        view.backgroundColor = mathMode == .addition ? .additionLightBrown : .subtractionLightBlue
        topView.backgroundColor = mathMode == .addition ? .additionBrown : .subtractionBlue
        progressBarViewBackground.backgroundColor = mathMode == .addition ? .additionBrown : .subtractionBlue
    }
    
    
    func setProgressBarColor(isRightAnswer: Bool) {
        progressBarView.backgroundColor = isRightAnswer ? .green : .red
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.progressBarView.backgroundColor = UIColor.progressBarColor
        }
    }
       
    
    
}






















