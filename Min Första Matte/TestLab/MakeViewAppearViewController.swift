//
//  MakeViewAppearViewController.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-01-17.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class MakeViewAppearViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
  
    override var canBecomeFirstResponder: Bool {
        return true
    }
    

    func createCardView(posX: CGFloat, posY: CGFloat) {
        
        let cardViewCopy = UIView()
        
        cardViewCopy.frame.size.width = 150
        cardViewCopy.frame.size.height = 150
        cardViewCopy.center.x = posX
        cardViewCopy.center.y = posY
        cardViewCopy.backgroundColor = .additionBrown

        self.view.addSubview(cardViewCopy)
        
        addPanGesutre(view: cardViewCopy)
    }
    
    

    
    
    func addPanGesutre(view: UIView) {
        let panGest = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        
        view.addGestureRecognizer(panGest)
    }
        
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        guard let handledView = sender.view else { return }
        
        switch sender.state {
        case .began, .changed:
            moveView(currentView: handledView, sender: sender)
        case .ended:
            handledView.removeFromSuperview()
        case .failed:
            break
            // return to orig pos?
        default:
            break
        }
    }
    
    
    func moveView(currentView: UIView, sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        currentView.center = CGPoint(
            x: currentView.center.x + translation.x,
            y: currentView.center.y + translation.y)
        
        sender.setTranslation(CGPoint.zero, in: view)
        view.bringSubviewToFront(currentView)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self.view)
        
        createCardView(posX: location.x, posY: location.y)
    }
    
    
    
    
   
}













/*firstNumber = Card()
secondNumber = Card()
thirdNumber = Card()

guard let thirdNumber = thirdNumber else { return }
if let secondNumber = secondNumber {
    secondNumber.number = 2
}

firstNumber?.number = 9
thirdNumber.number = 3
print(firstNumber?.number)
print(thirdNumber.number)
theView()*/


/*
 var viewIsPlaced = false
 
 var firstNumber: Card?
 var secondNumber: Card?
 var thirdNumber: Card?
 

 */



/*
 func theView() {
      var customView = UIView()
      customView.frame = CGRect.init(x: 0, y: 0, width: 180, height: 180)
      customView.backgroundColor = UIColor.black
      customView.center = self.view.center
      self.view.addSubview(customView)
  }

  
  // VIew that gets placed on touch
  func secondView(x : CGFloat, y : CGFloat) {
      
      let myNewView = UIView(frame: CGRect(x: x, y: y, width: 180, height: 180))
      
      myNewView.backgroundColor = UIColor.red
      
      
      
      self.view.addSubview(myNewView)
  }
  
  
  
  
  
  func longPressSquare() {
      
      let mySquare = UIView(frame:CGRect(x: 100, y: 100, width: 200, height: 200))
      mySquare.backgroundColor = .purple

      mySquare.isUserInteractionEnabled = true // true by default?
      self.view.addSubview(mySquare)
      
      
      
      //let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
      //mySquare.addGestureRecognizer(longPress)
      
  }
 */


/*
 @objc func handleLongPress(sender: UIGestureRecognizer) {
     
     
     if sender.state == .began {
         print("LONG PRESS")
         createDraggableView(posX: 100, posY: 100)
         
     }
 }
 */
