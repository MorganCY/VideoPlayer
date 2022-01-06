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

    var avPlayer: AVPlayer?
    var isNextTrackButton: Bool
    var currentTrack = 0
    var videoQueue: [Video]?
    var updateCurrentTrack: ((Int) -> Void)?

    init(nextTrack isNextTrack: Bool) {
        self.isNextTrackButton = isNextTrack
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        if isNextTrackButton {
            addTarget(self, action: #selector(handleNextTrack(_:)), for: .touchUpInside)
        } else {
            addTarget(self, action: #selector(handlePreviousTrack(_:)), for: .touchUpInside)
        }
        setBackgroundImage()
        layoutPosition()
    }

    @objc private func handleNextTrack(_ sender: UIButton) {
        currentTrack += 1
        updateCurrentTrack?(currentTrack)
        guard let urlString = videoQueue?[currentTrack].url else { return }
        guard let url = URL(string: urlString) else { return }
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        avPlayer?.replaceCurrentItem(with: item)
    }

    @objc private func handlePreviousTrack(_ sender: UIButton) {
        currentTrack -= 1
        updateCurrentTrack?(currentTrack)
        guard let urlString = videoQueue?[currentTrack].url else { return }
        guard let url = URL(string: urlString) else { return }
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        avPlayer?.replaceCurrentItem(with: item)
    }

    private func setBackgroundImage() {
        if isNextTrackButton {
            setBackgroundImage(UIImage.asset(.next), for: .normal)
        } else {
            setBackgroundImage(UIImage.asset(.previous), for: .normal)
        }
    }

    private func layoutPosition() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.05),
            heightAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.05),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])

        if isNextTrackButton {
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: UIScreen.width / 3).isActive = true
        } else {
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: -(UIScreen.width / 3)).isActive = true
        }
    }
}
