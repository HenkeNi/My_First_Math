//
//  TestViewController.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2018-11-22.
//  Copyright © 2018 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var numberOneImage: UIImageView!
    @IBOutlet weak var numberOneBackImage: UIImageView!
    
    @IBOutlet weak var numberTwoImage: UIImageView!
    @IBOutlet weak var numberTwoBackImage: UIImageView!
    
    @IBOutlet weak var numberThreeImage: UIImageView!
    @IBOutlet weak var numberThreeBackImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func swapButton(_ sender: UIButton) {
        
        if sender.tag == 1 {
            
             UIView.transition(from: self.numberOneImage, to: self.numberOneBackImage, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
          
             DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            
             UIView.transition(from: self.numberOneBackImage, to: self.numberOneImage, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            }
        
            
           
            
           
            
        }
        
    }
    
  
    @IBAction func testAlertBtn(_ sender: Any) {
        
            AlertView.instance.showAlert(title: "Success", message: "That's the right answer!", alertType: .success)
        
    }
    
}
