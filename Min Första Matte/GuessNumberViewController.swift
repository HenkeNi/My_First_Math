//
//  GuessNumberViewController.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2018-12-14.
//  Copyright © 2018 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class GuessNumberViewController: UIViewController {

    
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    
    var numbersArray = ["Ett", "1", "TVÅ", "2", "TRE", "3", "FYRA", "4", "FEM", "5"]
    var shuffled = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        randomizeArray()
        
    }
    

    @IBAction func didPressButton(_ sender: UIButton) {
        
        
        
        
    }
    
    
    func randomizeArray() {
        
        for _ in 0..<numbersArray.count {
            
            let randomNumber = Int(arc4random_uniform(UInt32(numbersArray.count)))
            
            shuffled.append(numbersArray[randomNumber])
            
            numbersArray.remove(at: randomNumber)
            
        }
        print(shuffled)
    }
    
}
