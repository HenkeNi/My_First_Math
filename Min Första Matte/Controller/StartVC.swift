//
//  StartVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-10-01.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class StartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


    
    
    @IBAction func didPressAddition(_ sender: Any) {
        //performSegue(withIdentifier: "EasyAddMath", sender: self)
        
        let easyMath = UIStoryboard(name: "EasyMath", bundle: Bundle.main).instantiateViewController(identifier: "EasyMath") as! EasyMathVC
        easyMath.mathMode = .addition
        //let otherVC = storyboard.instantiateViewController(withIdentifier: "EasyMath") as! EasyMathVC
        self.present(easyMath, animated: true, completion:  nil)
    }
    
    
    @IBAction func didPressSubtraction(_ sender: Any) {
        
        let easyMath = UIStoryboard(name: "EasyMath", bundle: Bundle.main).instantiateViewController(identifier: "EasyMath") as! EasyMathVC
        easyMath.mathMode = .subtraction
        //let otherVC = storyboard.instantiateViewController(withIdentifier: "EasyMath") as! EasyMathVC
        self.present(easyMath, animated: true, completion:  nil)
        
    }

    
   
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "EasyMath" {
            
            if let easyMathVC = segue.destination as? EasyMathVC {
                easyMathVC.mathMode = .addition
                easyMathVC.text = "Goodbye"
            }
            //var additionMath = segue.destination as! EasyMathVC
            //additionMath.mathMode = .addition
            //additionMath.text = "Goodbye"
            /*if let easyMathVC = segue.destination as? EasyMathVC {
                print("addition")
                easyMathVC.mathMode = .addition
            }*/
        }
        /*if segue.identifier == "subtactionMath" {
            print("subtraction")
            if let easyMathVC = segue.destination as? EasyMathVC {
                easyMathVC.mathMode = .subtraction
            }
        }*/
    }*/

    @IBAction func testBtn(_ sender: Any) {
        
        /*let numberGenerator = NumberRandomizer()
        let numbers = numberGenerator.randomizeTwoNumbers(mathMode: .addition)
        let numb1 = numbers.0
        let numb2 = numbers.1
     
        print("\(numb1) & \(numb2)")*/
        
        
    }
    
}
