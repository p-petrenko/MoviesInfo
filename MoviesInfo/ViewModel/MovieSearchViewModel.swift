//
//  MovieSearchViewModel.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 13/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import RxSwift
import RxCocoa

class MovieSearchViewModel {
    
    let searchText = Variable("")
    let moviesVariable =  Variable<[Movie]?>(nil)
    lazy var movies: Driver<[Movie]> = {
        return self.searchText.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(TMDBManager.getMoviesForSearchString)
            .asDriver(onErrorJustReturn: [])
    }()
}
