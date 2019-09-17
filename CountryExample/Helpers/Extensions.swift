//
//  Extensions.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 17/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation


extension String {
    
    /// - Returns: the translated string in Translations file
    func localizedString() -> String {
        return NSLocalizedString(self, comment: "Error")
    }
}
