//
//  SearchService.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import Foundation

class SearchService: SearchProvider {
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    func searchMovies(with searchTerm: String, completionHandler: @escaping SearchCompletionHandler) {
        
        //create url components
        guard var urlComponents = URLComponents(string: "") else {
            return
        }
        
        //perform network request
        URLSession.shared.dataTask(with: urlComponents.url!) { [unowned self] (data, response, error) in
            
            if error != nil {
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            print(data)
            
            do {
                let movieResponse = try self.jsonDecoder.decode(SearchResult.self, from: data)
                completionHandler(.success(movieResponse.results!))
                
            } catch let error {
                print(error)
//                return failure(.serializationError)
            }
        }.resume()
    
        
    }
}
