//
//  DetailsViewModel.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import Foundation

final class DetailsViewModel {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String? {
        movie.title
    }
    
    var sinopse: String {
        movie.overview ?? ""
    }
    
    var releaseDate: String {
        movie.releaseDate ?? "Generic.Unknown".localized
    }
    
    var rating: String? {
        
        guard let rating = movie.voteAverage else {
            return nil
        }

        return "\(rating)"
    }
    
    var posterImageURL: URL? {
        movie.posterURL
    }
    
    var headerImageURL: URL? {
        movie.backdropURL
    }
}
