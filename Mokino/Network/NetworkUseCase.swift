//
//  NetworkUseCase.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import Foundation

protocol NetworkUseCase {

    func buildURLRequest(for serviceEndpoint: String, queryParameters: [URLQueryItem]) -> URL?
}


extension NetworkUseCase {
    
    func buildURLRequest(for serviceEndpoint: String, queryParameters: [URLQueryItem]) -> URL? {
        
        //create url components
        guard var urlComponents = URLComponents(string: "\(NetworkConstants.baseURL)\(serviceEndpoint)") else {
            return nil
        }
        
        //create query items
        let apiKeyParameter = URLQueryItem(name: NetworkConstants.Parameters.apiKey.rawValue, value: NetworkConstants.apiKey)
        let queryItems = queryParameters + [apiKeyParameter]
        urlComponents.queryItems = queryItems
        
        //generate valid url
        guard let url = urlComponents.url else {
            return nil
        }
        
        return url
    }
}
