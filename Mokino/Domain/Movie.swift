//
//  Movie.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import Foundation

struct Movie: Codable, Hashable {
    
    let id: Int
    let title: String?
    let backdropPath: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: Date?
    let voteAverage: Double?
   
    public var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }
    
    public var backdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath ?? "")")
    }
    
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
