//
//  SearchAPI.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import Foundation

class SearchAPI: SearchProvider {
    
    let provider: SearchProvider
    let favoritesRepository: FavoritesRepository
    let hiddenMoviesRepository: HiddenMoviesRepository
    
    init(provider: SearchProvider, favoritesRepository: FavoritesRepository, hiddenMoviesRepository: HiddenMoviesRepository) {
        self.provider = provider
        self.favoritesRepository = favoritesRepository
        self.hiddenMoviesRepository = hiddenMoviesRepository
    }
    
    func searchMovies(with searchTerm: String, completionHandler: @escaping SearchCompletionHandler) {
        
        provider.searchMovies(with: searchTerm) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                
                let filteredHiddenMovies = self.filterMovies(for: movies)
                completionHandler(.success(filteredHiddenMovies))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    func filterMovies(for movies: [Movie]) -> [Movie] {
        
        let hiddenMovies = self.hiddenMoviesRepository.getMovies()
        let favoriteMovies = self.favoritesRepository.getMovies()
        
        let tmpMovies = movies.filter { tmpMovie in
            return !hiddenMovies.contains(where: {$0.id == tmpMovie.id})
        }
    
        tmpMovies.forEach { movie in
            movie.updateFavorite(favoriteMovies.contains(where: { $0.id == movie.id}))
        }
        
        return tmpMovies
    }
}
