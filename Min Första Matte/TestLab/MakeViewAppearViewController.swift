//
//  MakeViewAppearViewController.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-01-17.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class MakeViewAppearViewController: UIViewController {

    var viewIsPlaced = false
    
    var firstNumber: Card?
    var secondNumber: Card?
    var thirdNumber: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNumber = Card()
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
        theView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self.view)
        print(location.x, location.y)
        
        secondView(x: location.x, y: location.y)
    }
    

    
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
  
}
