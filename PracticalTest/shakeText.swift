//
//  shakeText.swift
//  PracticalTest
//
//  Created by Smeet R. Chavda on 9/5/17.
//  Copyright © 2017 Smeet R. Chavda. All rights reserved.
//

import Foundation

class ShakingTextField: UITextField {
    
    
    func shake () {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
        
    }
    
}
