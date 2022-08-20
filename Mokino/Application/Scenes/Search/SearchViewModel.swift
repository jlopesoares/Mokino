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
    
    let searchAPI: SearchAPI
    let favoritesRepository: FavoritesRepository
    private(set) var datasource = [Movie]()
    
    init(searchAPI: SearchAPI, favoritesRepository: FavoritesRepository) {
        self.searchAPI = searchAPI
        self.favoritesRepository = favoritesRepository
    }
}

//MARK: - Service
extension SearchViewModel {

    func getMovies(for searchTerm: String, completionHandler: @escaping SearchCompletionHandler) {
        
        searchAPI.searchMovies(with: searchTerm) { result in
            
            switch result {
            case .success(let movie):
                self.datasource = movie
                
            case .failure(let error):
                break
            }
            
            completionHandler(result)
        }
    }
}
