//
//  NetworkConstants.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import Foundation

struct NetworkConstants {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let apiKey = ""
    
    enum Parameters: String {
        case apiKey = "api_key",
        adult = "include_adult",
        query = "query"
    }
}
