//
//  NetworkConstants.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import Foundation

struct NetworkConstants {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let apiKey = "ae5b867ee790efe19598ff6108ad4e02"
    
    enum Parameters: String {
        case apiKey = "api_key",
        adult = "include_adult",
        query = "query"
    }
}
