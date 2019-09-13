//
//  FileManager.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 13/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

/// Handle the FileReadManager errors with a description
struct FileReadManagerError: Error {
    
    enum ErrorKind: Error {
        case pathNotFound
        case infoPlistMalformed
        case keyNotFound
    }
    
    let description: String
    let kind: ErrorKind
}


/// Class for reading property list object
/// For retrieving Api Keys
class FileReadManager {
    
    fileprivate enum ApiKey: String {
        case apiKeys
        case plist
        case restapi 
    }
    
    static let shared: FileReadManager = FileReadManager()
    
    private init() { }
    
    /// Function to retrieve api keys to used them in the rest api requests
    /// - Returns: Optional string with api key for request the country list
    /// - Throws: pathNotFound, infoPlistNotFound and keyNotFound
    func getApiKey() throws -> String {
        guard let pathToInfoPlist = Bundle.main.path(forResource: ApiKey.apiKeys.rawValue, ofType: ApiKey.plist.rawValue) else {
            throw FileReadManagerError(description: "The resource \(ApiKey.apiKeys.rawValue) has not been found on the main bundle path", kind: .pathNotFound)
        }
        guard let apiDictionary = NSDictionary(contentsOfFile: pathToInfoPlist) else {
            throw FileReadManagerError(description: "There is no dictionary asociated to the \(ApiKey.apiKeys.rawValue) plist file", kind: .infoPlistMalformed)
        }
        guard let key = apiDictionary[ApiKey.restapi.rawValue] as? String else {
            throw FileReadManagerError(description: "The key \(ApiKey.restapi.rawValue) is not found on the \(ApiKey.apiKeys.rawValue) dictionary", kind: .keyNotFound)
        }
        return key
    }
    
}
