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
    
    func roundedCornersView() {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft , .topRight, .bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
