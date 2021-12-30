//
//  MovieDetailViewModel.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 27/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel {
    private let bag = DisposeBag()
    let movie: BehaviorRelay<Movie>
    
    init(movie: Movie) {
        self.movie = BehaviorRelay(value: movie)
    }
}
