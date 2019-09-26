//
//  UnsplashImage.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 20/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

class UnsplashUrlImage: Decodable {
    
    let regular: String
    let full: String
    let small: String
    
}

/// Class for handle the unsplash image retrievement
class UnsplashImage: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case hexColor = "color"
        case urls
    }
    
    let id: String
    let hexColor: String
    let urls: UnsplashUrlImage
    
}
