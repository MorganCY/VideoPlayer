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

    var avPlayer: AVPlayer?

    // Define the video is playing or being paused
    var isPlaying: Bool {
        /// Rate == 0 refers to pause while 1 plays the video
        return avPlayer?.rate != 0 && avPlayer?.error == nil
    }
    // Rate of avPlayer for observation purpose
    var kvoRateContext = 0

    func setup() {
        addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        addObservers()
        updateImage()
        layoutPosition()
    }

    // Observe the current rate of avPlayer
    func addObservers() {
        avPlayer?.addObserver(self, forKeyPath: "rate", options: .new, context: &kvoRateContext)
    }

    @objc func tapped(_ sender: UIButton) {
        updateStatus()
        updateImage()
    }

    private func updateStatus() {
        if isPlaying {
            avPlayer?.pause()
        } else {
            avPlayer?.play()
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

    private func setBackgroundImage(_ asset: ImageAsset) {
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
