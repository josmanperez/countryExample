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

extension UISearchBar {
    
    func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    func setPlaceholder(textColor: UIColor) { getTextField()?.setPlaceholder(textColor: textColor) }
    func setClearButton(color: UIColor) { getTextField()?.setClearButton(color: color) }
}

extension UITextField {
    
    private class Label: UILabel {
        private var _textColor = UIColor.lightGray
        override var textColor: UIColor! {
            set { super.textColor = _textColor }
            get { return _textColor }
        }

        init(label: UILabel, textColor: UIColor = .lightGray) {
            _textColor = textColor
            super.init(frame: label.frame)
            self.text = label.text
            self.font = label.font
        }

        required init?(coder: NSCoder) { super.init(coder: coder) }
    }
    
    private class ClearButtonImage {
        static private var _image: UIImage?
        static private var semaphore = DispatchSemaphore(value: 1)
        static func getImage(closure: @escaping (UIImage?)->()) {
            DispatchQueue.global(qos: .userInteractive).async {
                semaphore.wait()
                DispatchQueue.main.async {
                    if let image = _image { closure(image); semaphore.signal(); return }
                    guard let window = UIApplication.shared.windows.first else { semaphore.signal(); return }
                    let searchBar = UISearchBar(frame: CGRect(x: 0, y: -200, width: UIScreen.main.bounds.width, height: 44))
                    window.rootViewController?.view.addSubview(searchBar)
                    searchBar.text = "txt"
                    searchBar.layoutIfNeeded()
                    _image = searchBar.getTextField()?.getClearButton()?.image(for: .normal)
                    closure(_image)
                    searchBar.removeFromSuperview()
                    semaphore.signal()
                }
            }
        }
    }
    
    var placeholderLabel: UILabel? { return value(forKey: "placeholderLabel") as? UILabel }
    
    func setClearButton(color: UIColor) {
        ClearButtonImage.getImage { [weak self] image in
            guard   let image = image,
                let button = self?.getClearButton() else { return }
            button.imageView?.tintColor = color
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    func setPlaceholder(textColor: UIColor) {
        guard let placeholderLabel = placeholderLabel else { return }
        let label = Label(label: placeholderLabel, textColor: textColor)
        setValue(label, forKey: "placeholderLabel")
    }
    
    func getClearButton() -> UIButton? { return value(forKey: "clearButton") as? UIButton }

}
