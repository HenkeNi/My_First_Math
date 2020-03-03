//
//  Extension+UI.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-05-21.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

extension UIView {
    
    
    func roundedCorners(myRadius : CGFloat, borderWith: CGFloat?, myColor : UIColor?) {
        
        self.layer.cornerRadius = self.frame.size.height/myRadius
        //.clipsToBounds = true
        self.layer.masksToBounds = true
       
        if let border = borderWith {
            self.layer.borderWidth = 2
        }
        
        if let color = myColor {
            self.layer.borderColor = color.cgColor
        }
    }
    
    func showShadows() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    func flipView(duration: Double) {
        
        UIView.transition(with: self, duration: duration, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    
    func returnToPosition(position: CardPosition) {
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            
            self.center.x = CGFloat(position.xPosition)
            self.center.y = CGFloat(position.yPosition)
            
        }, completion: nil)
        
        
    }
    
    
}
