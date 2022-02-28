//
//  PlayPauseButton.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/4.
//

import Foundation
import AVFoundation
import UIKit
import AVKit

class PlayPauseButton: UIButton {

    var player: AVQueuePlayer?

    // Define the video is playing or being paused
    private var isPlaying: Bool {
        /// Rate == 0 refers to pause while 1 plays the video
        return player?.rate != 0 && player?.error == nil
    }
    // Rate of avPlayer for observation purpose
    private var kvoRateContext = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        addObservers()
        updateImage()
        layoutPosition()
    }

    // Observe the current rate of avPlayer
    private func addObservers() {
        player?.addObserver(self, forKeyPath: "rate", options: .new, context: &kvoRateContext)
    }

    @objc private func tapped(_ sender: UIButton) {
        updateStatus()
        updateImage()
    }

    private func updateStatus() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
    }

    private func updateImage() {
        if isPlaying {
            setBackgroundImage(.pause)
        } else {
            setBackgroundImage(.play)
        }
    }

    private func layoutPosition() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.06),
            heightAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.06),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }

    private final func setBackgroundImage(_ asset: ImageAsset) {
        setBackgroundImage(UIImage.asset(asset), for: .normal)
    }

    private func handleRateChanged() {
        updateImage()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let context = context else { return }

        switch context {
        case &kvoRateContext:
            handleRateChanged()
        default:
            break
        }
    }
}
