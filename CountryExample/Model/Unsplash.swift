//
//  Unsplash.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 24/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

/// Unsplash class to handle the url of an image
class Unsplash {
    
    let name: String
    fileprivate let apiRequest: ApiRestClient<ApiUnsplashResponse> = {
        do {
            let dictionary = try FileReadManager.shared.getApiDictionary(with: .unsplash)
            guard let apikey = dictionary["key"] as? String, let url = dictionary["url"] as? String else {
                return ApiRestClient<ApiUnsplashResponse>(urlServer: "")
            }
            let api = ApiRestClient<ApiUnsplashResponse>(urlServer: "\(url)/?client_id=\(apikey)")
            return api
        } catch {
            return ApiRestClient<ApiUnsplashResponse>(urlServer: "")
        }
    }()
    
    init(name: String) {
        self.name = name
    }
    
    func getUrl(closure: @escaping ((String?) -> Void)) {
        apiRequest.urlServer += "&query=\(name)"
        apiRequest.request { (success, image) in
            if success {
                closure(image?.results.randomElement()?.urls.regular)
            } else {
                closure(nil)
            }
        }
    }
}
