//
//  ObservableType+Extension.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 30.12.2021.
//  Copyright © 2021 Polina Petrenko. All rights reserved.
//

import RxSwift
import RxCocoa

extension ObservableType {

    public func unwrap<Result>() -> Observable<Result> where E == Result? {
        return self.filter { $0 != nil }.map { $0! }
    }
}
