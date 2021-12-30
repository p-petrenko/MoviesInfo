//
//  MovieSearchDisplayController.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 11/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class MovieSearchDisplayController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var searchVM: MovieSearchViewModel!
    private var navigator: Navigator!
    private let disposeBag = DisposeBag()
    
    static func createWith(navigator: Navigator, storyboard: UIStoryboard, viewModel: MovieSearchViewModel) -> MovieSearchDisplayController {
        let vc = storyboard.instantiateViewController(ofType: MovieSearchDisplayController.self)
        vc.navigator = navigator
        vc.searchVM = viewModel
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // UI settings
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        title = "Movies"
        configureSearchBar()
        
        bindUI()
    }
    
    // bind UI with ViewModel
    func bindUI() {
        // Create a dataSource object and pass it SectionOfMovies type
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfMovies>(
            configureCell: { dataSource, tableView, indexPath, movie in
                guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
                    fatalError("Could not dequeue MovieCell with identifier: \(MovieCell.identifier)")
                }
                movieCell.update(with: movie)
                return movieCell
        })
        
        // there is only one section, selected index is a row number
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: searchVM.selectedIndex$)
            .disposed(by: disposeBag)
        
        // navigate to detail screen
        searchVM.selectedMovie$
            .subscribe(onNext: { movieItem in
                self.navigator.show(segue: .movieDetails(movie: movieItem), sender: self)
            })
            .disposed(by: disposeBag)

        
        // Define the actual data as an Observable sequence of Movie objects and bind it to the tableView
        searchVM.movieResultSection$
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // pass a text from searchBar to view model
        searchBar.rx.text
            .orEmpty
            .bind(to: searchVM.searchText)
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .bind { _ in self.view.endEditing(true) }
            .disposed(by: disposeBag)
    }
    
    func configureSearchBar() {
        searchBar.showsCancelButton = true
        searchBar.text = "Guardians of the Galaxy"
        searchBar.placeholder = "Search for a movie"
    }
}
