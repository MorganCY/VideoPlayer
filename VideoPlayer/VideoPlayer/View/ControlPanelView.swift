//
//  ControlPanel.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/6.
//

import Foundation
import UIKit
import AVFoundation

class ControlPanelView: UIView {

    private var player: AVPlayer?
    private var videoQueue: [Video]?

    private let playPauseButton = PlayPauseButton()
    private let fastForwardButton = ChangeTimeButton(fastForward: true)
    private let rewindButton = ChangeTimeButton(fastForward: false)
    private let nextTrackButton = TrackButton(nextTrack: true)
    private let previousTrackButton = TrackButton(nextTrack: false)
    private var videoNameLabel = VideoNameLabel(text: "")
    private let closeButton = CloseButton()
    var closeView: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, player: AVPlayer?, videoQueue: [Video]?) {
        self.init(frame: frame)
        self.player = player
        self.videoQueue = videoQueue
        setupControls()
        backgroundColor = .black.withAlphaComponent(0.5)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupControls() {
        addControls()
        setupControl()
        setupPlayer()
        setupQueue()
        updateTrack()
        setupClose()
    }

    private func addControls() {
        addSubview(playPauseButton)
        addSubview(fastForwardButton)
        addSubview(rewindButton)
        addSubview(nextTrackButton)
        addSubview(previousTrackButton)
        addSubview(videoNameLabel)
        addSubview(closeButton)
    }

    private func setupControl() {
        videoNameLabel = VideoNameLabel(text: videoQueue?.first?.name ?? "")
        playPauseButton.setup()
        fastForwardButton.setup()
        rewindButton.setup()
        nextTrackButton.setup()
        previousTrackButton.setup()
        closeButton.setup()
        videoNameLabel.layoutPosition()
    }

    private func setupPlayer() {
        playPauseButton.avPlayer = player
        fastForwardButton.avPlayer = player
        rewindButton.avPlayer = player
        nextTrackButton.avPlayer = player
        previousTrackButton.avPlayer = player
    }

    private func setupQueue() {
        nextTrackButton.videoQueue = videoQueue
        previousTrackButton.videoQueue = videoQueue
    }

    private func updateTrack() {
        nextTrackButton.updateCurrentTrack = { [weak self] track in
            self?.previousTrackButton.currentTrack = track
        }
        previousTrackButton.updateCurrentTrack = { [weak self] track in
            self?.nextTrackButton.currentTrack = track
        }
    }

    private func setupClose() {
        closeButton.closeView = { [weak self] in
            self?.closeView?()
        }
    }
}
