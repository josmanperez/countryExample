//
//  MapHelper.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 18/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation
import MapKit

/// Class for handle all functions related with Mapkit
class MapHelper: NSObject, MKAnnotation {
    let title: String?
    let capital: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, capital: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.capital = capital
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        if let _capital = capital {
            return "Capital".localizedString() + ": \(_capital)"
        } else {
            return "-"
        }
    }
}
