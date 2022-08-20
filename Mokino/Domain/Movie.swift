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
    
    var isFavorite: Bool = false
    
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
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case overview = "overview"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        title = try? values.decode(String.self, forKey: .title)
        backdropPath = try? values.decode(String.self, forKey: .backdropPath)
        posterPath = try? values.decode(String.self, forKey: .posterPath)
        overview = try? values.decode(String.self, forKey: .overview)
        releaseDate = try? values.decode(Date.self, forKey: .releaseDate)
        voteAverage = try? values.decode(Double.self, forKey: .voteAverage)
    }
}
