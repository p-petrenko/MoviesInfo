//
//  MovieCell.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 11/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell, Identifiable {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!

    func update(with movie: Movie) {
        let releaseYearString = (movie.releaseDate != nil) ? " (\(movie.releaseDate!.year))" : ""
        title.text = movie.title + releaseYearString
        overview.text = movie.overview
        photo.kf.setImage(with: movie.posterURL)
    }
}
