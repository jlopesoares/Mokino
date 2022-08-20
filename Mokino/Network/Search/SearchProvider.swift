//
//  SearchProvider.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import Foundation

typealias SearchCompletionHandler = (Result<[Movie], Error>) -> ()

protocol SearchProvider {
    
    func searchMovies(with searchTerm: String, completionHandler: @escaping SearchCompletionHandler)
}
