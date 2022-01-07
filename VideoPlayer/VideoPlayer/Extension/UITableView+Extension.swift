//
//  UITableView+Extension.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/7.
//

import Foundation
import UIKit

extension UITableView {

    func registerCellWithNib(identifier: String, bundle: Bundle?) {
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifier)
    }

    func registerHeaderWithNib(identifier: String, bundle: Bundle?) {
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}

extension UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }

    func hideSelectionStyle() {
        self.selectionStyle = .none
    }
}

extension UITableViewHeaderFooterView {

    static var identifier: String {
        return String(describing: self)
    }
}
