//
//  SecondAdditionViewController.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2018-11-24.
//  Copyright © 2018 Henrik Jangefelt Nilsson. All rights reserved.
//

// TODO: GÖR ENgen scroll view? med pan gesture som bytar sifforna


// Kunna scrolla genom att dra fingret fram och tillbaka på progressbaren
// Kolla vilken bild det är istället för sender.tag?
// Bilder i en array?
// Buttons på sidorna om brickorna - scrolla fram och tillbaka (bara 5st hela tiden)

import UIKit

class AdditionIntermediateVC: UIViewController {

    @IBOutlet weak var answerView: UIView!
    
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewThree: UIView!
    @IBOutlet weak var viewFour: UIView!
    @IBOutlet weak var viewFive: UIView!
    @IBOutlet weak var viewSix: UIView!
    @IBOutlet weak var viewSeven: UIView!
    @IBOutlet weak var viewEight: UIView!
    @IBOutlet weak var viewNine: UIView!
    @IBOutlet weak var viewTen: UIView!
    
    
    var viewOneOriginalPosition : CGPoint!
    var viewTwoOriginalPosition : CGPoint!
    var viewThreeOriginalPosition : CGPoint!
    var viewFourOriginalPosition : CGPoint!
    var viewFiveOriginalPosition : CGPoint!
    var viewSixOriginalPosition : CGPoint!
    var viewSevenOriginalPosition : CGPoint!
    var viewEightOriginalPosition : CGPoint!
    var viewNineOriginalPosition : CGPoint!
    var viewTenOriginalPosition : CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewOneOriginalPosition = viewOne.center
        viewTwoOriginalPosition = viewTwo.center
        viewThreeOriginalPosition = viewThree.center
        viewFourOriginalPosition = viewFour.center
        viewFiveOriginalPosition = viewFive.center
        viewSixOriginalPosition = viewSix.center
        viewSevenOriginalPosition = viewSeven.center
        viewEightOriginalPosition = viewEight.center
        viewNineOriginalPosition = viewNine.center
        viewTenOriginalPosition = viewTen.center
    }

    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        
        
        // GÖR OM MED TRANSLATION
        if(recognizer.state == .changed)
        {
            let translation = recognizer.translation(in: self.view)
            if let view = recognizer.view {
                view.center = CGPoint(x:view.center.x + translation.x,
                                      y:view.center.y + translation.y)
                
            }
            recognizer.setTranslation(CGPoint.zero, in: self.view)
            
        }
     
        if recognizer.state == .began {
            
            
            //self.view.bringSubviewToFront(recognizer.view!)
            //customView = MyCustomView(frame: CGRect(x: 0, y: 0, width: 1800, height: 180))
            //self.view.addSubview(customView)
        }
        
        if recognizer.state == .ended {
            print(recognizer.view!.center)
            print(answerView.center)

            var distance = abs(answerView.center.x-recognizer.view!.center.x)
            distance = distance + abs(answerView.center.y-recognizer.view!.center.y)
            
        
            var xDistance = abs(answerView.center.x/2 - recognizer.view!.center.x)
            
            if xDistance < 210 {
                print("Nära")
            }
            
            if distance < 100 {
                    
                print("Hello")
                recognizer.view!.center = answerView.center
                
                
            }
            else {
                originalPosition()
                
            }
        }
        
    } // Slut på handelPan
    
    // Trollar fram en ny view. Gamla blir osynlig?
    //let appearingNumber = UIView(frame: CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: 180, height: 180)
    //let appearingNumberPic = UIImageView(frame: CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: 180, height: 180)))
    
    //apperingNumberPic.addSubview(appearingNumber)
    
    func originalPosition() {
        
        viewOne.center = viewOneOriginalPosition
        viewTwo.center = viewTwoOriginalPosition
        viewThree.center = viewThreeOriginalPosition
        viewFour.center = viewFourOriginalPosition
        viewFive.center = viewFiveOriginalPosition
        viewSix.center = viewSixOriginalPosition
        viewSeven.center = viewSevenOriginalPosition
        viewEight.center = viewEightOriginalPosition
        viewNine.center = viewNineOriginalPosition
        viewTen.center = viewTenOriginalPosition
    }
    
    func addView() {
        
        
        
    }

}
