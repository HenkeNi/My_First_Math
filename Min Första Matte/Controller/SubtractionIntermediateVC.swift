//
//  SecondSubtractionViewController.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-01-08.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class SubtractionIntermediateVC: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var fourthView: UIView!
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var fourthImage: UIImageView!
    
    @IBOutlet weak var answerView: UIView!
    
    var firstViewOriginalPosition : CGPoint!
    var secondViewOriginalPosition : CGPoint!
    var thirdViewOriginalPosition : CGPoint!
    var fourthViewOriginalPosition : CGPoint!

    var indexPath = 0
    var levelIndex = 0
    
    var correctAnswers = [Int]()
    var leftImage = [String]()
    var rightImage = [String]()
    
    //let picturesArray = [UIImage]()
    let picturesArray : [UIImage] = [UIImage(named: "NumberZero")!, UIImage(named: "NumberOne")!, UIImage(named: "NumberTwo")!, UIImage(named: "NumberThree")!, UIImage(named: "NumberFour")!, UIImage(named: "Number5")!, UIImage(named: "Card6")!, UIImage(named: "Card7")!, UIImage(named: "Card8")!,
        UIImage(named: "Card9")!,]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.appearance().isExclusiveTouch = true
        
        firstImage.image = UIImage(named: "NumberZero")
        secondImage.image = UIImage(named: "NumberOne")
        thirdImage.image = UIImage(named: "NumberTwo")
        fourthImage.image = UIImage(named: "NumberThree")
        
        // Lägg till rätta svarets (view) tag
        //correctAnswers.append(<#T##newElement: Int##Int#>)
        //leftImage.append("")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        firstViewOriginalPosition = firstView.center
        secondViewOriginalPosition = secondView.center
        thirdViewOriginalPosition = thirdView.center
        fourthViewOriginalPosition = fourthView.center
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
            // Sätter den viewn man drar i framför dem andra
            self.view.bringSubviewToFront(recognizer.view!)
        }
        if recognizer.state == .ended {
            var distance = abs(answerView.center.x-recognizer.view!.center.x)
            distance = distance + abs(answerView.center.y-recognizer.view!.center.y)
            
            if distance < 100 {
                
                recognizer.view!.center = answerView.center
            } else {
                originalPosition()
            }
        }
    }
    
    
    @IBAction func scrollPicturesButton(_ sender: UIButton) {
        if sender.tag == 1 {
            
            if indexPath <= 0 {
                indexPath = 0
            } else {
                indexPath -= 1
            }
            
        }
        if sender.tag == 2 {
            
            if indexPath < picturesArray.count - 4 {
                indexPath += 1
            } else {
                indexPath = picturesArray.count - 4
            }
            
            
            
        }
        firstImage.image = picturesArray[indexPath]
        secondImage.image = picturesArray[indexPath + 1]
        thirdImage.image = picturesArray[indexPath + 2]
        fourthImage.image = picturesArray[indexPath + 3]
        print(indexPath)
    }
    
    func originalPosition() {
        
        firstView.center = firstViewOriginalPosition
        secondView.center = secondViewOriginalPosition
        thirdView.center = thirdViewOriginalPosition
        fourthView.center = fourthViewOriginalPosition
    }
    
}
