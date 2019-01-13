//
//  String+Extension.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 13/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import Foundation

extension String {
    var TMDBImageURL: URL? {
        let baseImageURL = URL(string: Constants.baseImageURLString)!
        return baseImageURL.appendingPathComponent(PosterSizes.DetailPoster).appendingPathComponent(self)
    }
    
}
