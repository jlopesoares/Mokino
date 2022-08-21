//
//  Movie.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import Foundation

class Movie: Codable, Hashable {
    
    let id: Int
    let title: String?
    let backdropPath: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let voteAverage: Double?
    var favorite: Bool = false
    var hidden: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case overview = "overview"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case favorite = "favorite"
        case hidden = "hidden"
    }
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        title = try? values.decode(String.self, forKey: .title)
        backdropPath = try? values.decode(String.self, forKey: .backdropPath)
        posterPath = try? values.decode(String.self, forKey: .posterPath)
        overview = try? values.decode(String.self, forKey: .overview)
        releaseDate = try? values.decode(String.self, forKey: .releaseDate)
        voteAverage = try? values.decode(Double.self, forKey: .voteAverage)
        
        if let favorite = try? values.decode(Bool.self, forKey: .favorite) {
            self.favorite = favorite
        }
        
        if let hidden = try? values.decode(Bool.self, forKey: .hidden) {
            self.hidden = hidden
        }
    }
    
    public var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }
    
    public var backdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath ?? "")")
    }
    
    func updateFavorite(_ favorite: Bool) {
        self.favorite = favorite
    }
    
    func updateHidden(_ hidden: Bool) {
        self.hidden = hidden
    }
    
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id && lhs.favorite == rhs.favorite
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
