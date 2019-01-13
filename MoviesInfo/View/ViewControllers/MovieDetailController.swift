//
//  MovieDetailController.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 11/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailController: UIViewController, Identifiable {

    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    
    
    var chosenMovie: Movie! {
        didSet {
            fillUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillUI()
    }
    
    func fillUI() {
        guard isViewLoaded else {
            return
        }
        guard let chosenMovie = chosenMovie else {
            return
        }
        title = chosenMovie.title
        overviewTextView.text = chosenMovie.overview
        filmImageView.kf.setImage(with: chosenMovie.posterURL)
    }

}
