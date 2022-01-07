//
//  MenuTableViewHeader.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/7.
//

import Foundation
import UIKit

class MenuTableViewHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!

    func layouLabel(with displayName: String) {
        titleLabel.text = displayName
    }
}


