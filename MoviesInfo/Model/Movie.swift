//
//  Movie.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 11/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var id: Int
    var title: String
    var posterPath: String?
    var posterURL: URL?
    var originalTitle: String
    var overview: String
    var releaseDateString: String
    var releaseDate: Date?
}

extension Movie {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case overview
        case releaseDateString = "release_date"
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-mm-dd"
        return formatter
    }()
    
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Movie.dateFormatter)
        return decoder
    }()
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        let posterPathString = try container.decode(String.self, forKey: .posterPath)
        posterURL = posterPathString.TMDBImageURL
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        overview = try container.decode(String.self, forKey: .overview)
        releaseDateString = try container.decode(String.self, forKey: .releaseDateString)
        releaseDate = Movie.dateFormatter.date(from: releaseDateString)
    }
    
}
