//
//  ProgressBar.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-03-27.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit

class ProgressBar: UIView {

    var progressView = UIView()
    var progressIsFull: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        progressView.frame.size.height = self.frame.size.height
        progressView.frame.size.width = 0.0
        progressView.backgroundColor = .yellow
        self.addSubview(progressView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // TODO: SET muliplication?? gånga bred av self med progressbar
    func increaseProgress(amount: CGFloat) {
        let width = progressView.frame.size.width
        progressView.frame.size.width = width >= self.frame.size.width ? self.frame.size.width : width + amount
        progressIsFull = width >= self.frame.size.width
        //currentLength = currentLength >= maxLength ? maxLength : currentLength + increaseAmount
    }

    func decreaseProgress(amount: CGFloat) {
        let width = progressView.frame.size.width

        progressView.frame.size.width = width <= 0.0 ? 0.0 : width - amount
    }

    func setProgressWidth(amount: CGFloat) {
        progressView.frame.size.width = amount
    }
    
    func resetProgress() {
        progressView.frame.size.width = 0.0
    }

    
    
    
//    func setProgressBarColor(isRightAnswer: Bool) {
//         progressBarView.backgroundColor = isRightAnswer ? .progressBarColor : .progressBarFailColor
//
//         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
//             self.progressBarView.backgroundColor = UIColor.progressBarColor
//         }
//     }
    
}
