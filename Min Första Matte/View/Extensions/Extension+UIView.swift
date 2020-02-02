//
//  Extension+UI.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-05-21.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func roundedCorners(myRadius : CGFloat, borderWith: CGFloat?, myColor : UIColor?) {
        
        self.layer.cornerRadius = self.frame.size.height/myRadius
        //self.clipsToBounds = true
        self.layer.masksToBounds = true
        
        if let border = borderWith {
            self.layer.borderWidth = 2
        }
        
        if let color = myColor {
            self.layer.borderColor = color.cgColor
        }
    }
    
    func flipView(duration: Double) {
        
        UIView.transition(with: self, duration: duration, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    
}
