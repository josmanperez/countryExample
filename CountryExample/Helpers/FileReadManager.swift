//
//  FileReadManager.swift
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
    
    enum ApiKey: String {
        case apiKeys
        case plist
        case restapikey
        case restapiurl
        case unsplash
    }
    
    static let shared: FileReadManager = FileReadManager()
    
    private init() { }
    
    /// Function to retrieve api keys to used them in the rest api requests
    /// - Returns: Optional string with api key for request based on key
    /// - Parameters: key `ApiKey` to retrieve value
    /// - Throws: pathNotFound, infoPlistNotFound and keyNotFound
    func getApiValue(with key: ApiKey) throws -> String {
        guard let pathToInfoPlist = Bundle.main.path(forResource: ApiKey.apiKeys.rawValue, ofType: ApiKey.plist.rawValue) else {
            throw FileReadManagerError(description: "The resource \(ApiKey.apiKeys.rawValue) has not been found on the main bundle path", kind: .pathNotFound)
        }
        guard let apiDictionary = NSDictionary(contentsOfFile: pathToInfoPlist) else {
            throw FileReadManagerError(description: "There is no dictionary asociated to the \(ApiKey.apiKeys.rawValue) plist file", kind: .infoPlistMalformed)
        }
        guard let _key = apiDictionary[key.rawValue] as? String else {
            throw FileReadManagerError(description: "The key \(key.rawValue) is not found on the \(ApiKey.apiKeys.rawValue) dictionary", kind: .keyNotFound)
        }
        return _key
    }
    
    /// Function to retrieve api keys to used them in the rest api requests
    /// - Returns: Dictionary of string with api, key
    /// - Parameters: key `ApiKey` to retrieve value
    /// - Throws: pathNotFound, infoPlistNotFound and keyNotFound
    func getApiDictionary(with key: ApiKey) throws -> NSDictionary {
        guard let pathToInfoPlist = Bundle.main.path(forResource: ApiKey.apiKeys.rawValue, ofType: ApiKey.plist.rawValue) else {
            throw FileReadManagerError(description: "The resource \(ApiKey.apiKeys.rawValue) has not been found on the main bundle path", kind: .pathNotFound)
        }
        guard let apiDictionary = NSDictionary(contentsOfFile: pathToInfoPlist) else {
            throw FileReadManagerError(description: "There is no dictionary asociated to the \(ApiKey.apiKeys.rawValue) plist file", kind: .infoPlistMalformed)
        }
        guard let _key = apiDictionary[key.rawValue] as? NSDictionary else {
            throw FileReadManagerError(description: "The key \(key.rawValue) is not found on the \(ApiKey.apiKeys.rawValue) dictionary", kind: .keyNotFound)
        }
        return _key
    }
    
}
