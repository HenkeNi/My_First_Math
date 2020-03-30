//
//  ProgressBarView.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-03-28.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class ProgressBarView: UIView {
    
    @IBOutlet weak var progressBarContainer: UIView!
    @IBOutlet weak var progressBar: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ProgressBarView", owner: self, options: nil)
        
    }
}
