//
//  SearchAPI.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import Foundation

class SearchAPI: SearchProvider {
    
    let provider: SearchProvider
    
    init(provider: SearchProvider) {
        self.provider = provider
    }
    
    func searchMovies(with searchTerm: String, completionHandler: @escaping SearchCompletionHandler) {
        provider.searchMovies(with: searchTerm, completionHandler: completionHandler)
    }
}
