//
//  PanGestVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-12.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class PanGestVC: UIViewController {

    
    @IBOutlet var dragViews: [UIView]!
    
    var fileOrig: CGPoint!
    
    var panGesture = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for dragV in dragViews {
            addPanGesture(view: dragV)
        }
        fileOrig = dragViews[0].frame.origin
    }
    
    
    
    
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(PanGestVC.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        guard let fileView = sender.view else { return }
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            fileView.center = CGPoint(x: fileView.center.x + translation.x, y: fileView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
            
        case .ended:
            break
        default:
            break
        }
        
    }
    
    
  



}
