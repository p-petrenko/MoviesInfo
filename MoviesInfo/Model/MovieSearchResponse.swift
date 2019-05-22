//
//  MovieSearchResponse.swift
//  RxTMDBMovieList
//
//  Created by Polina Petrenko on 07/05/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import Foundation

/// response data for search/movie request
struct MovieSearchResult: Decodable {
    let page, totalResults, totalPages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
