//
//  ProgressSlider.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/6.
//

import Foundation
import UIKit
import AVFoundation

class ProgressSlider: UISlider {

    var player: AVQueuePlayer?

    func setup() {
        addTarget(self, action: #selector(handleSliderMoves(_:)), for: .valueChanged)
        minimumTrackTintColor = .white
        maximumTrackTintColor = .gray
        layoutPosition()
        addDurationObserver()
    }

    private func addDurationObserver() {
        let interval = CMTime(value: 1, timescale: 1)

        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] time in
            if let duration = self?.player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(time)
                let totalSeconds = CMTimeGetSeconds(duration)
                self?.value = Float(seconds / totalSeconds)
            }
        })
    }

    @objc private func handleSliderMoves(_ sender: UISlider) {
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime)
        }
    }

    private func layoutPosition() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 32),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 16),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -16),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -32)
        ])
    }
}
