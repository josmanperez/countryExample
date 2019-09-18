//
//  Extensions.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 17/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /// - Returns: the translated string in Translations file
    func localizedString() -> String {
        return NSLocalizedString(self, comment: "Error")
    }
}

extension UIView {
    
    func cornerRadius(with size: CGFloat) {
        self.layer.cornerRadius = size
        self.clipsToBounds = true
    }
    
    func roundCorners(usingCorners corners: UIRectCorner, cornerRadius: CGSize) {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    
    func roundedCornersView() {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft , .topRight, .bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    /// Function to set a gradient for the background cells and round corners
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
