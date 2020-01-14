//
//  UIView+Ext.swift
//  Recipe Book
//
//  Created by Jesus Andres Bernal Lopez on 1/11/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit
import AudioToolbox

extension UIView {
    
    func rounded() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layoutIfNeeded()
    }
    
    func vibratePhone() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    func shake() {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        animation.fromValue = CGPoint(x: center.x - 7, y: center.y)
        animation.toValue = CGPoint(x: center.x + 7, y: center.y)
        animation.duration = 0.04
        animation.repeatCount = 4
        animation.autoreverses = true
        
        self.layer.add(animation, forKey: "position")
    }
}
