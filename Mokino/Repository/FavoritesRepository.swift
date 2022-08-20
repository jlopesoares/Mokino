//
//  FavoritesRepository.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import Foundation

struct FavoritesRepository: RepositoryUseCase{
    
    func getMovies() -> [Movie] {
        getMovies(for: .favorites)
    }
    
    func updateState(for movie: Movie) {

        updateState(for: movie, on: .favorites)
    }
}
