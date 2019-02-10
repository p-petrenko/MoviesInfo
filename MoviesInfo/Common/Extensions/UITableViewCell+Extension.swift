//
//  UITableViewCell+Extension.swift
//  MoviesInfo
//
//  Created by Polina Petrenko on 09/02/2019.
//  Copyright © 2019 Polina Petrenko. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}
