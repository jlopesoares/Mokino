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
    private(set) var datasource = [Movie]()
    
    init(searchAPI: SearchAPI) {
        self.searchAPI = searchAPI
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
