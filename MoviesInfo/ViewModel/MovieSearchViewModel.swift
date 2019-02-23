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
    
    let searchText = BehaviorRelay<String>(value: "")
    let movies = BehaviorRelay<[Movie]?>(value: nil)
    private let bag = DisposeBag()
    
    init() {
        searchText.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(TMDBManager.getMoviesForSearchString)
            .bind(to: movies)
            .disposed(by: bag)
    }
}
