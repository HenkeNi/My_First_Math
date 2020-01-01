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
    
    
    
    
    // Rounded corners, border width (and color) for Cards
    func customizeCards() {
        
        for cardView in cardViews {
            cardView.roundedCorners(myRadius: 20, borderWith: 5, myColor: .darkGray)
        }
    }
    
    
    // FIX! sätt kortet som är på viewn till att bestämma labeltexten
    // Updates the label text
    func updateCardLabels() {
        
        for (index, label) in cardLabels.enumerated() {
            
            switch label.tag {
            case 1, 2, 3, 4, 5:
                label.text = cards[index].number.convertIntToString()
//            case 6:
//                label.text = topCards[0].number.convertIntToString()
//            case 7:
//                label.text = topCards[1].number.convertIntToString()
            default:
                label.text = ""
            }
            
        }
    }
    
    func updateTopCardLabels() {
          
        for label in cardLabels {
            
            switch label.tag {
            case 6:
                print("\(topCards[0].labelText)")
                label.text = topCards[0].number.convertIntToString()
            case 7:
                label.text = topCards[1].number.convertIntToString()
            default:
                continue
            }
        }
    }
    
    
    
    func setMathOperatorsImages(mathMode: CalculationMode) {
                
        for cardImage in cardImages {
            
            switch cardImage.tag {
            case 8:
                cardImage.image = mathMode == .addition ? UIImage(named: "NumberPlus") : UIImage(named: "NumberMinus")
            case 9:
                cardImage.image = mathMode == .addition ? UIImage(named: "NumberEqual") : UIImage(named: "NumberEqualMinus")
            default:
                break
            }
        }
    }
    
    
    // OBS: gjorde closuresen statiska samt lade till EasyMathVC. funktitonene!!!
    
    // Returns closure expression for updating progressbar
     func updateProgressBar(isRightAnswer: Bool) -> (CGFloat, CGFloat) -> CGFloat {
        return isRightAnswer ? EasyMathVC.increaseProgress : EasyMathVC.decreaseProgress
     }
     
     // Closure expression for increasing progressbar
     static let increaseProgress: (CGFloat, CGFloat) -> CGFloat = { (barWidth: CGFloat, containerWidth: CGFloat) -> CGFloat in
                 
         return barWidth >= containerWidth ? containerWidth : barWidth + (containerWidth * 0.1)
     }
     
     // Closure expression for decreasing progressbar
     static let decreaseProgress: (CGFloat, CGFloat) -> CGFloat = { (barWidth: CGFloat, containerWidth: CGFloat) -> CGFloat in
         
         return barWidth < 0 ? 0.0 : barWidth - (containerWidth * 0.1)
     }
     
    
    // FIXA
    static let resetProgress: (CGFloat, CGFloat) -> CGFloat = { (barWidth: CGFloat, containerWidth: CGFloat) -> CGFloat in
        return 0
    }
    
    
    
    
    
     // SKAPA CARDIMAGES programmetical
         
     //TODO: GÖR OM TVP OLIKA (EN flr bottom cards och en för topcards)
     //func updateBtmCardImages() {
     func updateCardImages() {
         
         for (index, cardImage) in cardImages.enumerated() {
                 
             switch cardImage.tag {
             case 1, 2, 3, 4, 5:
                 cardImage.image = UIImage(named: cards[index].imageName)
             case 6:
                 cardImage.image = UIImage(named: topCards[0].imageName)
             case 7:
                 cardImage.image = UIImage(named: topCards[1].imageName)
             default:
                 break
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
    
    
    // Sets right background color based on CalculationMode
       func setBackgroundColors(mathMode: CalculationMode) {
           
           view.backgroundColor = mathMode == .addition ? .additionLightBrown : .subtractionLightBlue
           topView.backgroundColor = mathMode == .addition ? .additionBrown : .subtractionBlue
           progressBarViewBackground.backgroundColor = mathMode == .addition ? .additionBrown : .subtractionBlue
       }
       
    
    
}
