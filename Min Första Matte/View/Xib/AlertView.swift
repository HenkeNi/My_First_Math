//
//  Alert.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-15.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class AlertView: UIView {
        
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    static let instance = AlertView()
//    var delegate: UpdateLevel?
//    var listener: EasyMathVC?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        checkImage.roundedCorners(myRadius: 2, borderWith: nil, myColor: .black)
        
        alertView.roundedCorners(myRadius: 10, borderWith: nil, myColor: nil)
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
    enum AlertType {
        case success
        case nextLevel
    }
    
    
    func showAlert(title: String, message: String, alertType: AlertType) {
        
        self.titelLabel.text = title
        self.messageLabel.text = message
        
        switch alertType {
        case .success:
            checkImage.image = UIImage(named:"OkCheck")
            doneBtn.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .nextLevel:
            checkImage.image = UIImage(named:"OkCheck")
        }
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    
    
    @IBAction func onClickDone(_ sender: Any) {
        
//        listener = EasyMathVC()
//        self.delegate = listener
//        delegate?.updateLevel()
//        self.delegate = nil
        
        let name = NSNotification.Name(rawValue: nxtLvlNotificationKey)
        NotificationCenter.default.post(name: name, object: nil)
        
        parentView.removeFromSuperview()

    }
}
