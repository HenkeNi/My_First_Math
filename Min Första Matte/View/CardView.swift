//
//  CardView.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-03-30.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit
// TODO: Use delegation????
class CardView: UIView {
    
    
    var position: CGPoint?
    var imageView: UIImageView?
    var label: UILabel?

    
    init(frame: CGRect, imgName: String, labelText: String) {
        super.init(frame: frame)

        self.roundedCorners(borderWidth: 5, myColor: .darkGray)
        addUIImageView(imgName: imgName)
        addUILabel(labelText: labelText)
        
        position = self.center // save position
        addPanGesture()
        addTapGesuter()
    }
    
   required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
   
    func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        self.addGestureRecognizer(panGesture)
    }
       
    
    // OWn class or something??
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began, .changed:
            updateViewPosition(sender: sender)
        case .ended:
            self.center = position!
        default:
            break;
        }
    }
    
    func updateViewPosition(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: superview!) // Change to superView?
        
        self.center = CGPoint(
            x: self.center.x + translation.x,
            y: self.center.y + translation.y)
        
        sender.setTranslation(CGPoint.zero, in: superview!) // in superview?
        superview!.bringSubviewToFront(self)
    }
    
    
    func addUIImageView(imgName: String) {
        
        imageView = UIImageView()
        if let imageView = imageView {
            self.addSubview(imageView)
            imageView.image = UIImage(named: imgName)
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        }
    }

    
    // TODO: Set text type
    func addUILabel(labelText: String) {
        label = UILabel()
        
        if let label = label {
            self.addSubview(label)
            label.text = labelText
            label.textAlignment = .center;
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
    }
    
    
    func updateImage(imageName: String) {
        imageView?.image = UIImage(named: imageName)
    }
    
    func updateLabel(labelText: String) {
        label?.text = labelText
    }
    
    
    func addTapGesuter() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedCard))
        self.addGestureRecognizer(tapGesture)
    }
    
   // Flip
    @objc func tappedCard() {
        self.flipView(duration: 0.3)
     }
 
    
    
    
    
    
 
   
    
   
}
