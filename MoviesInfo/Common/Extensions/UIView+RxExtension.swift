//
//  UIView+RxExtension.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 18/05/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    
    /// dismiss keyboard
    public var endEditing: Binder<Bool> {
        return Binder(self.base) { view, endEditing  in
            view.endEditing(endEditing)
        }
    }
}
