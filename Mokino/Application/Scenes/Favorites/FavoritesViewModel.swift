//
//  FavoritesViewModel.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import Foundation

final class FavoritesViewModel {
    
    private var repository: FavoritesRepository
    
    init(favoriteRepository: FavoritesRepository) {
        self.repository = favoriteRepository
    }
    
    func getFavoriteMovies() -> [Movie] {
        
        return repository.getMovies()
    }
    
    func removeFavorite(_ movie: Movie) {
        repository.updateState(for: movie)
    }
}
