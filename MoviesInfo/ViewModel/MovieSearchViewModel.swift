//
//  MovieSearchViewModel.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 13/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class MovieSearchViewModel {
    
    /// gets new value on every search input
    let searchText = BehaviorRelay<String>(value: "")

    /// movie search request result
    private lazy var movieSearchResult$: Observable<[Movie]> = searchText
        .debug("searchText$")
        .filter { !$0.isEmpty }
        .debug("searchText$ filtered")
        .throttle(0.5, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .flatMapLatest(TMDBManager.getMoviesForSearchString)

    /// movie search result in a format, convenient for table view update with RxDataSources
    private (set) lazy var movieResultSections$: Observable<[SectionOfMovies]> = movieSearchResult$.map { [SectionOfMovies(items: $0)] }
}

// RxDataSources Step 1. Start by defining your sections with a struct that conforms to the SectionModelType protocol
struct SectionOfMovies {
    var items: [Item]
}

extension SectionOfMovies: SectionModelType {
    typealias Item = Movie
    
    init(original: SectionOfMovies, items: [Item]) {
        self = original
        self.items = items
    }
}
