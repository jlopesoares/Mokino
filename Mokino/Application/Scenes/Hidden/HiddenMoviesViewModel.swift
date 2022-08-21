//
//  HiddenMoviesViewModel.swift
//  Mokino
//
//  Created by João Pedro on 21/08/2022.
//

import Foundation

final class HiddenMoviesViewModel {
    
    private let repository: HiddenMoviesRepository
    
    init(repository: HiddenMoviesRepository) {
        self.repository = repository
    }
    
    func getMovies() -> [Movie] {
        return repository.getMovies()
    }
}

//MARK: - Hide
extension HiddenMoviesViewModel {
    
    func removeHidden(_ movie: Movie) {
        repository.updateState(for: movie)
    }
}
