//
//  SearchResult.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import Foundation

struct SearchResult: Codable {
    var page: Int?
    var results: [Movie]?
    var totalPages: Int?
    var totalResults: Int?
}
