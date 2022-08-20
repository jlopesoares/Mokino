//
//  SearchService.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import Foundation

class SearchService: SearchProvider, NetworkUseCase {
    
    private let jsonDecoder: JSONDecoder = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return jsonDecoder
    }()
    
    func searchMovies(with searchTerm: String, completionHandler: @escaping SearchCompletionHandler) {
        
        let queryItems = [
            URLQueryItem(name: NetworkConstants.Parameters.adult.rawValue, value: "false"),
            URLQueryItem(name: NetworkConstants.Parameters.query.rawValue, value: searchTerm)
        ]
        
        guard let url = buildURLRequest(for: "search/movie", queryParameters: queryItems) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [unowned self] (data, response, error) in
            
            if let error = error {
                completionHandler(.failure(error))
            }
            
            guard
                let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode,
                let data = data
            else {
                return
            }
            
            do {
                let movieResponse = try self.jsonDecoder.decode(SearchResult.self, from: data)
                completionHandler(.success(movieResponse.results!))
                
            } catch let error {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}
