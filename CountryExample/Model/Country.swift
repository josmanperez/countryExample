//
//  Country.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 12/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

/// Model class to store Countries
class Country:Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case capital
        case region
        case subregion
        case population
        case latlng
        case nativeName
        case flag = "alpha2Code"
    }
    
    var name: String
    var capital: String
    var region: String
    var subregion: String
    var population: Int
    var latlng: [Double]?
    var nativeName: String?
    var flag: String
}
