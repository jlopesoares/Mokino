//
//  SearchViewModel.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import Foundation

enum SearchSections {
    case movies
}

final class SearchViewModel {
    
    private let searchAPI: SearchAPI
    private(set) var datasource = [Movie]()
    
    init(searchAPI: SearchAPI) {
        self.searchAPI = searchAPI
    }
}

//MARK: - Service
extension SearchViewModel {

    var filteredDatasource: [Movie] {
        return searchAPI.filterMovies(for: datasource)
    }
    
    func getMovies(for searchTerm: String, completionHandler: @escaping SearchCompletionHandler) {
        
        searchAPI.searchMovies(with: searchTerm) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.datasource = movies
                completionHandler(.success(movies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

//MARK: - Favorites
extension SearchViewModel {
    
    func updateFavoriteState(for movie: Movie) {
        searchAPI.favoritesRepository.updateState(for: movie)
    }
}

//MARK: - Hide
extension SearchViewModel {
    
    func updateHideState(for movie: Movie) {
        searchAPI.hiddenMoviesRepository.updateState(for: movie)
    }
}
