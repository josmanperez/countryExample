//
//  CountryExampleTests.swift
//  CountryExampleTests
//
//  Created by Josman Pérez Expósito on 12/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import XCTest
@testable import CountryExample

class CountryExampleTests: XCTestCase {
    
    let mockJson = """
[
  {
    "name": "Afghanistan",
    "topLevelDomain": [
      ".af"
    ],
    "alpha2Code": "AF",
    "alpha3Code": "AFG",
    "callingCodes": [
      "93"
    ],
    "capital": "Kabul",
    "altSpellings": [
      "AF",
      "Afġānistān"
    ],
    "region": "Asia",
    "subregion": "Southern Asia",
    "population": 26023100,
    "latlng": [
      33.0,
      65.0
    ],
    "demonym": "Afghan",
    "area": 652230.0,
    "gini": 27.8,
    "timezones": [
      "UTC+04:30"
    ],
    "borders": [
      "IRN",
      "PAK",
      "TKM",
      "UZB",
      "TJK",
      "CHN"
    ],
    "nativeName": "افغانستان",
    "numericCode": "004",
    "currencies": [
      "AFN"
    ],
    "languages": [
      "ps",
      "uz",
      "tk"
    ],
    "translations": {
      "de": "Afghanistan",
      "es": "Afganistán",
      "fr": "Afghanistan",
      "ja": "アフガニスタン",
      "it": "Afghanistan"
    },
    "relevance": "0"
  }]
""".data(using: .utf8)!
    

    var sut: URLSession!
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    /// Creates a country of a JSON Mock
    func testCreateCountry() {
        do {
            let decoder = JSONDecoder()
            let countries = try decoder.decode([Country].self, from: mockJson)
            XCTAssertEqual(countries.count, 1)
            XCTAssertEqual(countries.first?.name, "Afghanistan")
            XCTAssertEqual(countries.first?.capital, "Kabul")
            XCTAssertEqual(countries.first?.region, "Asia")
            XCTAssertEqual(countries.first?.subregion, "Southern Asia")
            XCTAssertEqual(countries.first?.population, 26023100)
            
        } catch let e {
            XCTFail(e.localizedDescription)
        }
    }
    
    /// Asynchronous test request 200
    func testValidCallGetsHTTPStatusCode200() {
        do {
            let _key = try FileReadManager.shared.getApiValue(with: .restapikey)
            let _url = try FileReadManager.shared.getApiValue(with: .restapiurl)
            guard let url = URL(string: _url) else {
                XCTFail("No url")
                return
            }
            
            var request = URLRequest(url: url)
            request.addValue(_key, forHTTPHeaderField: Constants.headerCountryApiKey)
            let promise = expectation(description: "Status code: 200")
            
            let dataTask = sut.dataTask(with: request) { data, response, error in
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                    return
                } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    if statusCode == 200 {
                        promise.fulfill()
                    } else {
                        XCTFail("Status code: \(statusCode)")
                    }
                }
            }
            dataTask.resume()
            wait(for: [promise], timeout: 5)
        } catch let e {
            XCTFail(e.localizedDescription)
        }
    }


}
