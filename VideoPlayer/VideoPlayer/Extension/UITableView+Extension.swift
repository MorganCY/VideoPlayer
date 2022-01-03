//
//  UICollectionView+Extension.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import UIKit

extension UITableView {

    func registerCellWithNib(identifier: String, bundle: Bundle?) {
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifier)
    }
}

extension UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }
}
