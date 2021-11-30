//
//  Movie.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 11/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import Foundation

struct Movie: Codable {

    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let originalTitle: String?
    let originalLanguage: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let video: Bool
    let voteAverage: Double?
    let voteCount: Int?
    
    private enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-mm-dd"
        return formatter
    }()
    
    func getReleaseDate() -> Date? {
        if let releaseDateUnwrapped = releaseDate {
            return dateFormatter.date(from: releaseDateUnwrapped)
        }
        return nil
    }
    
    func getPosterURL() -> URL? {
        return posterPath?.TMDBImageURL
    }
}
