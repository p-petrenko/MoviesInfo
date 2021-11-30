//
//  MovieDetailController.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 11/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class MovieDetailController: UIViewController, Identifiable {

    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var userScore: UILabel!
    
    private var navigator: Navigator!
    private var viewModel: MovieDetailViewModel!
    private let bag = DisposeBag()
    
    static func createWith(navigator: Navigator, storyboard: UIStoryboard, viewModel: MovieDetailViewModel) -> MovieDetailController {
        let vc = storyboard.instantiateViewController(ofType: MovieDetailController.self)
        vc.navigator = navigator
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindUI()
    }
    
    func bindUI() {
        title = viewModel.movie.value.title
        bag.insert(
            viewModel.movie.map{ "\($0.voteAverage ?? 0)" }.bind(to: userScore.rx.text),
            viewModel.movie.map{ "\($0.overview ?? "")" }.bind(to: overviewTextView.rx.text),
            viewModel.movie.map{ "User score: \(($0.voteAverage ?? 0) * 10)%" }.bind(to: userScore.rx.text)
        )
        filmImageView.kf.setImage(with: viewModel.movie.value.getPosterURL())
    }
}
