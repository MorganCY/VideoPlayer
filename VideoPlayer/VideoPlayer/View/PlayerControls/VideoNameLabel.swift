//
//  VideoNameLabel.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/4.
//

import Foundation
import UIKit

class VideoNameLabel: UILabel {

    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        textColor = .white
        font = UIFont.systemFont(ofSize: 16)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layoutPosition() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: 32),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 32),
            widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.3)
        ])
    }
}
