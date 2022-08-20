//
//  HiddenMoviesRepository.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import Foundation

struct HiddenMoviesRepository: RepositoryUseCase {
    
    func getMovies() -> [Movie] {
        getMovies(for: .hidden)
    }
    
    func updateState(for movie: Movie) {
        
        updateState(for: movie, on: .hidden)
    }
}
