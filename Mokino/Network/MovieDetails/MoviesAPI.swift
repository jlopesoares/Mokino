//
//  MoviesAPI.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import Foundation

struct MoviesAPI: MoviesProvider {
    
    private let provider: MoviesProvider
    
    init(provider: MoviesProvider) {
        self.provider = provider
    }
    
    func getMovieDetails(_ identifier: String, completionHandler: @escaping MovieDetailsCompletion) {
        
        provider.getMovieDetails(identifier, completionHandler: completionHandler)
    }
}
