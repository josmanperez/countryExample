//
//  ApiUnsplashResponse.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 24/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

class ApiUnsplashResponse: Decodable {
    let results: [UnsplashImage]
}
