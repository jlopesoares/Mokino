//
//  String+Extensions.swift
//  Mokino
//
//  Created by João Pedro on 21/08/2022.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
