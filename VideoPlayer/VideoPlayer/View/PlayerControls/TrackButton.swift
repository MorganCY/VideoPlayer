//
//  SelectTrackButton.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/5.
//

import Foundation
import UIKit
import AVFoundation

class TrackButton: UIButton {

    var player: AVQueuePlayer?

    func setup() {
        addTarget(self, action: #selector(handleNextTrack(_:)), for: .touchUpInside)
        setBackgroundImage()
        layoutPosition()
    }

    @objc private func handleNextTrack(_ sender: UIButton) {
        player?.advanceToNextItem()
        checkCurrentItem()
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
            widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.05),
            heightAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.05),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: UIScreen.width / 3)
        ])
    }
}
