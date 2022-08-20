//
//  RepositoryUseCase.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import Foundation

enum UserDefaultsKeys: String {
    case favorites = "mokino_favorites",
    hidden = "mokino_hidden"
}

protocol RepositoryUseCase {
    
    func getMovies() -> [Movie]
    func updateState(for movie: Movie)
}

extension RepositoryUseCase {
    
    internal func getMovies(for repositoryIdentifier: UserDefaultsKeys) -> [Movie] {
       
        guard let data = UserDefaults.standard.value(forKey: repositoryIdentifier.rawValue) as? Data else {
            return []
        }
        
        let movies = try? JSONDecoder().decode([Movie].self, from: data)
        return movies ?? []
    }
    
    internal func updateState(for movie: Movie, on repository: UserDefaultsKeys) {
        
        var tmpMovies = getMovies()
        
        if let savedMovieIndex = tmpMovies.firstIndex(where: {$0.id == movie.id}) {
            tmpMovies.remove(at: savedMovieIndex)
        } else {
            tmpMovies.append(movie)
        }
        
        let data = try? JSONEncoder().encode(tmpMovies)
        UserDefaults.standard.set(data, forKey: repository.rawValue)
    }
}
