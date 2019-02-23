//
//  Navigator.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 12/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import UIKit
import RxCocoa



class Navigator {    
    lazy private var defaultStoryboard = UIStoryboard(name: "Main", bundle: nil)

    // MARK: - segues list
    enum Segue {
        case movieList
        case movieDetails(movie: BehaviorRelay<Movie>)
    }
    
    // MARK: - invoke a single segue
    func show(segue: Segue, sender: UIViewController) {
        switch segue {
        case .movieList:
            // show movies search screen
            let vm = MovieSearchViewModel()
            let movieSearchVC = MovieSearchDisplayController
                .createWith(navigator: self,
                            storyboard: sender.storyboard ?? defaultStoryboard,
                            viewModel: vm)
            show(target: movieSearchVC, sender: sender)
        case .movieDetails(movie: let film):
            //show movie details
            let vm = MovieDetailViewModel(movie: film)
            let movieDetaiVC = MovieDetailController
                .createWith(navigator: self,
                            storyboard: sender.storyboard ?? defaultStoryboard,
                            viewModel: vm)
            show(target: movieDetaiVC, sender: sender)
        }
    }
    
    private func show(target: UIViewController, sender: UIViewController) {
        if let nav = sender as? UINavigationController {
            //push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        }

        if let nav = sender.navigationController {
            //add controller to navigation stack
            nav.pushViewController(target, animated: true)
        } else {
            //present modally
            sender.present(target, animated: true, completion: nil)
        }
    }
}
