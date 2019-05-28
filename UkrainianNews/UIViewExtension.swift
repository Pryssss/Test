//
//  UIViewExtension.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/28/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//

import UIKit

extension UIView {
    fileprivate static let rotationAnimationKey = "rotationanimationkey"
    
    func startRotating(duration: CFTimeInterval = 3, clockwise: Bool = true, delay: CFTimeInterval = 0) {
        
        if self.layer.animation(forKey: UIView.rotationAnimationKey) != nil {
            return
        }
        
        let direction = clockwise ? 1.0 : -1.0
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.beginTime = CACurrentMediaTime() + delay
        animation.toValue = NSNumber(value: .pi * 2 * direction)
        animation.duration = duration
        animation.repeatCount = Float.infinity
        
        self.layer.add(animation, forKey: UIView.rotationAnimationKey)
    }
    
    func stopRotating() {
        self.layer.removeAnimation(forKey: UIView.rotationAnimationKey)
    }
}
