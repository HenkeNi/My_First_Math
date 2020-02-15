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
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    func flipView(duration: Double) {
        
        UIView.transition(with: self, duration: duration, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    
}
