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
        progressBarView.backgroundColor = isRightAnswer ? .green : .red
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.progressBarView.backgroundColor = UIColor.progressBarColor
        }
    }
       
    
    
}











// Puts right image on the card
  /*func updateCardImages() {
      
      for cardImage in cardImages {
          
          switch cardImage.tag {
              
          case 1:
              cardImage.image = UIImage(named: cards[0].imageName)
          case 2:
              cardImage.image = UIImage(named: cards[1].imageName)
          case 3:
              cardImage.image = UIImage(named: cards[2].imageName)
          case 4:
              cardImage.image = UIImage(named: cards[3].imageName)
          case 5:
              cardImage.image = UIImage(named: cards[4].imageName)
          case 6:
              cardImage.image = UIImage(named: topCards[0].imageName)
          case 7:
              cardImage.image = UIImage(named: topCards[1].imageName)
          default:
              break
          }
      }
  }*/










   /* func updateCardLabels(cardLabels: [UILabel], associatedCards: [Card]) {
            
            for (index, label) in cardLabels.enumerated() {
                
                switch label.tag {
                case <#pattern#>:
                    <#code#>
                default:
                    <#code#>
                }
            }
        }*/
        
        
//        // FIX! sätt kortet som är på viewn till att bestämma labeltexten
//        // Updates the label text
//        func updateCardLabels() {
//
//            for (index, label) in cardLabels.enumerated() {
//
//                switch label.tag {
//                case 1, 2, 3, 4, 5:
//                    label.text = playableCards[index].number.convertIntToString()
//    //            case 6:
//    //                label.text = topCards[0].number.convertIntToString()
//    //            case 7:
//    //                label.text = topCards[1].number.convertIntToString()
//                default:
//                    label.text = ""
//                }
//
//            }
//        }
//
//        func updateTopCardLabels() {
//
//            for label in cardLabels {
//
//                switch label.tag {
//                case 6:
//                    print("\(equationCards[0].labelText)")
//                    label.text = equationCards[0].number.convertIntToString()
//                case 7:
//                    label.text = equationCards[1].number.convertIntToString()
//                default:
//                    continue
//                }
//            }
//        }


/*func updateCardImages() {
       
       for (index, cardImage) in cardImages.enumerated() {
               
           switch cardImage.tag {
           case 1, 2, 3, 4, 5:
               cardImage.image = UIImage(named: playableCards[index].imageName)
           case 6:
               cardImage.image = UIImage(named: equationCards[0].imageName)
           case 7:
               cardImage.image = UIImage(named: equationCards[1].imageName)
           default:
               break
           }
           
       }
   }*/



// COmbine with below? FIX!! Egen klass?
  /*func setMathOperatorsImages(mathMode: CalculationMode) {
               
      for image in operatorCardImages {
           
           switch image.tag {
           case 1:
               image.image = mathMode == .addition ? UIImage(named: "NumberPlus") : UIImage(named: "NumberMinus")
           case 2:
               image.image = mathMode == .addition ? UIImage(named: "NumberEqual") : UIImage(named: "NumberEqualMinus")
           default:
               break
           }
       }
   }*/
