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
    
    /// index of a selected item
    let selectedIndex$ = BehaviorRelay<Int?>(value: nil)

    /// movie search request result
    private lazy var movieSearchResult$: Observable<[Movie]> = searchText
        .filter { !$0.isEmpty }
        .throttle(0.5, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .flatMapLatest(TMDBManager.getMoviesForSearchString)
        // map MovieSearchResult to array of movies
        .map { $0.results }
    
    /// movie search result in a format, convenient for table view update with RxDataSources
    private (set) lazy var movieResultSection$ = movieSearchResult$.map { [SectionOfMovies(items: $0)] }

    /// a movie which was selected
    private (set) lazy var selectedMovie$ = selectedIndex$.unwrap()
        .withLatestFrom(movieResultSection$) {  (index, movieSection) in movieSection.first?.items[index] }
        .unwrap()

}

/// a struct that conforms to the SectionModelType protocol to use it with RxDataSources
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
