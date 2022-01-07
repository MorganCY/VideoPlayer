//
//  SelectTrackButton.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/5.
//

import Foundation
import UIKit
import AVFoundation

class NextTrackButton: UIButton {

    var player: AVQueuePlayer?
    var nextTrackHandler: (() -> Void)?

    func setup() {
        addTarget(self, action: #selector(handleNextTrack(_:)), for: .touchUpInside)
        setBackgroundImage()
        layoutPosition()
    }

    @objc private func handleNextTrack(_ sender: UIButton) {
        player?.advanceToNextItem()
        checkCurrentItem()
        nextTrackHandler?()
    }

    private func checkCurrentItem() {
        if player?.currentItem == player?.items().last {
            isHidden = true
        }
    }

    private func setBackgroundImage() {
        setBackgroundImage(UIImage.asset(.next), for: .normal)
    }

    private func layoutPosition() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.03),
            heightAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.03),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: -32),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
}
