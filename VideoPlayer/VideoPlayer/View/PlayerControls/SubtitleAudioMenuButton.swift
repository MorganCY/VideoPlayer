//
//  SubtitleAudioMenuButton.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/7.
//

import Foundation
import UIKit

class SubtitleAudioButton: UIButton {

    var openMenu: (() -> Void)?

    func setup() {
        addTarget(self, action: #selector(handleOpenMenu(_:)), for: .touchUpInside)
        setBackgroundImage()
        layoutPosition()
    }

    @objc private func handleOpenMenu(_ sender: UIButton) {
        openMenu?()
    }

    private func setBackgroundImage() {
        setBackgroundImage(UIImage.asset(.menu), for: .normal)
    }

    private func layoutPosition() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.04),
            heightAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.04),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: 32),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}
