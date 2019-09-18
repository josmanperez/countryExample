//
//  CountryCell.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 12/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit
import Kingfisher

class CountryCell: UICollectionViewCell {
    
    static let reuseIdentifier = "countryCell"
    static let nibName = "CountryCell"

    @IBOutlet weak var flagIcon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var capital: UILabel!
    let topColor = UIColor(red: 0/255, green: 142/255, blue: 155/255, alpha: 1.0)
    let bottomColor = UIColor(red: 44/255, green: 115/255, blue: 210/255, alpha: 1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground(colorTop: topColor, colorBottom: bottomColor)
    }
    
    func configureCell(with country: Country) {
        name.text = country.name
        capital.text = country.capital
        if let flag = UIImage(named: country.flag.uppercased()) {
            flagIcon.image = flag
        }
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
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft , .topRight, .bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }

}
