//
//  ApiRest.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 12/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

protocol ApiRest {
    associatedtype T
    var urlServer: String { get }
    func request(completionHandler: @escaping ((Bool, T?) -> Void))
}
