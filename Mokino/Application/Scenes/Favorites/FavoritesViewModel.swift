//
//  FavoritesViewModel.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import Foundation

final class FavoritesViewModel {
    
    var repository: FavoritesRepository
    
    init(favoriteRepository: FavoritesRepository) {
        self.repository = favoriteRepository
    }
    
    func getFavoriteMovies() -> [Movie] {
        
        return repository.getMovies()
    }
}
