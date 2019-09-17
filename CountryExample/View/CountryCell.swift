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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with country: Country) {
        name.text = country.name
        capital.text = country.capital
        if let flag = UIImage(named: country.flag.uppercased()) {
            flagIcon.image = flag
        }
    }

}
