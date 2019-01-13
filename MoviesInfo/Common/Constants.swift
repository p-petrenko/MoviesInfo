//
//  Constants.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 11/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import Foundation


struct Constants {
    static let baseImageURLString = "http://image.tmdb.org/t/p/"
    
    static let ApiKey : String = "4e8bdccc3bb63cefbec21f936eca5651"
}

struct ParameterKeys {
    static let ApiKey = "api_key"
    static let query = "query"
}

struct ResponseKeys {
    static let results = "results"
}


struct PosterSizes {
    private static let posterSizes = ["w92", "w154", "w185", "w342", "w500", "w780", "original"]
    static let RowPoster = posterSizes[2]
    static let DetailPoster = posterSizes[4]
}
