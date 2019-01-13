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

class MovieSearchDisplayController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = MovieSearchViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        configureSearchBar()
        title = "Movies"
        bindUI()

        searchBar.rx.text
            .orEmpty
            .filter { !$0.isEmpty }
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
    }
    
    func bindUI() {
        viewModel.movies.asObservable()
        .bind(to: viewModel.moviesVariable)
        .disposed(by: disposeBag)
        
        //show movies in table view when viewModel movies is updated
        viewModel.movies.asDriver()
            .drive(onNext: { [weak self] _ in self?.tableView.reloadData() })
            .disposed(by: disposeBag)
    }
    
    func configureSearchBar() {
        searchBar.showsCancelButton = true
        searchBar.text = "Guardians of the Galaxy"
        searchBar.placeholder = "Search for a movie"
    }
    
}

extension MovieSearchDisplayController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension MovieSearchDisplayController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesVariable.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            fatalError("Could not dequeue MovieCell with identifier: \(MovieCell.identifier)")
        }
        movieCell.update(with: viewModel.moviesVariable.value![indexPath.row])
        return movieCell
    }
}

extension MovieSearchDisplayController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let movie = viewModel.moviesVariable.value?[indexPath.row] else { return }
        // make a segue to MovieDetailController
        guard let vc = storyboard?.instantiateViewController(withIdentifier: MovieDetailController.identifier) as? MovieDetailController else { return }
        vc.chosenMovie = movie
        Navigator.show(target: vc, sender: self)
    }
    
}
