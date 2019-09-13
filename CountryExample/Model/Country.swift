//
//  Country.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 12/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation


class Country:Decodable {
    
    var name: String
    var capital: String
    var region: String
    var subregion: String
    var population: Int
    var latlong: [Float]
    var nativeName: String?
    
    
    
}
