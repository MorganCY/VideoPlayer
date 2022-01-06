//
//  TimeLabel.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/6.
//

import Foundation
import UIKit
import AVFoundation

class TotalTimeLabel: UILabel {

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
        getTotalTime()
    }

    private func getTotalTime() {
        if let currentItem = player?.currentItem {
            let duration = currentItem.asset.duration
            let seconds = CMTimeGetSeconds(duration)
            let secondsString = Int(seconds) % 60
            let minutesString = String(format: "%02d", Int(seconds) / 60)
            text = "\(minutesString):\(secondsString)"
        }
    }
}
