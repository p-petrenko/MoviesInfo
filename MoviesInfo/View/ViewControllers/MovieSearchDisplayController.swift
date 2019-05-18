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
        // RxDataSources Step 2. Create a dataSource object and pass it your SectionOfCustomData type:
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfMovies>(
            configureCell: { dataSource, tableView, indexPath, movie in
                guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
                    fatalError("Could not dequeue MovieCell with identifier: \(MovieCell.identifier)")
                }
                movieCell.update(with: movie)
                return movieCell
        })
        
        // RxDataSources Step 4. Define the actual data as an Observable sequence of CustomData objects and bind it to the tableView
        searchVM.movieResultSections$
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
