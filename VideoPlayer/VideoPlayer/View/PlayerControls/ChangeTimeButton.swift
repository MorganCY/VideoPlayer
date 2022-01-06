//
//  FastForwardButton.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/4.
//

import Foundation
import UIKit
import AVFoundation

class ChangeTimeButton: UIButton {

    var avPlayer: AVPlayer?
    var isFastForwardButton: Bool

    init(fastForward isFastForward: Bool) {
        self.isFastForwardButton = isFastForward
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        if isFastForwardButton {
            addTarget(self, action: #selector(handleFastForward(_:)), for: .touchUpInside)
        } else {
            addTarget(self, action: #selector(handleRewind(_:)), for: .touchUpInside)
        }
        setBackgroundImage()
        layoutPosition()
    }

    @objc private func handleFastForward(_ sender: UIButton) {
        guard let currentTime = avPlayer?.currentTime().seconds else { return }
        var fastForwardedTime: CMTime?
        fastForwardedTime = CMTime(seconds: currentTime + 10, preferredTimescale: 6000)

        guard let fastForwardedTime = fastForwardedTime else { return }
        avPlayer?.seek(to: fastForwardedTime)
    }

    @objc private func handleRewind(_ sender: UIButton) {

        guard let currentTime = avPlayer?.currentTime().seconds else { return }
        var fastForwardedTime: CMTime?
        fastForwardedTime = CMTime(seconds: currentTime - 10, preferredTimescale: 6000)

        guard let fastForwardedTime = fastForwardedTime else { return }
        avPlayer?.seek(to: fastForwardedTime)
    }

    private func setBackgroundImage() {
        if isFastForwardButton {
            setBackgroundImage(UIImage.asset(.fastForward), for: .normal)
        } else {
            setBackgroundImage(UIImage.asset(.rewind), for: .normal)
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

        if isFastForwardButton {
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: UIScreen.width / 5).isActive = true
        } else {
            centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: -(UIScreen.width / 5)).isActive = true
        }
    }
}
