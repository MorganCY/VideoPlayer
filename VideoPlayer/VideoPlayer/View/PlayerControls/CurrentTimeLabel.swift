//
//  TimeLabel.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/6.
//

import Foundation
import UIKit
import AVFoundation

class CurrentTimeLabel: UILabel {

    var player: AVQueuePlayer?

    init() {
        super.init(frame: .zero)
        textColor = .white
        font = UIFont.systemFont(ofSize: 14)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addDurationObserver()
    }

    private func addDurationObserver() {
        let interval = CMTime(value: 1, timescale: 1)

        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] time in
            let seconds = CMTimeGetSeconds(time)
            let secondsString = String(format: "%02d", Int(seconds) % 60)
            let minutesString = String(format: "%02d", Int(seconds) / 60)
            if let _ = self?.player?.currentItem?.duration {
                self?.text = "\(minutesString):\(secondsString)"
            }
        })
    }
}
