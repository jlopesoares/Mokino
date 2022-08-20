//
//  MoviesProvider.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import Foundation

typealias MovieDetailsCompletion = (Result<Movie, Error>) -> ()

protocol MoviesProvider {
    func getMovieDetails(_ identifier: String, completionHandler: @escaping MovieDetailsCompletion)
}
