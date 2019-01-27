//
//  Storyboard+Extension.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 27/01/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}
