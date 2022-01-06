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

    private var player: AVQueuePlayer?
    private var videos: [Video]?
    private var playerQueue: [AVPlayerItem] = []

    private let playPauseButton = PlayPauseButton()
    private let fastForwardButton = ChangeTimeButton(fastForward: true)
    private let rewindButton = ChangeTimeButton(fastForward: false)
    private let nextTrackButton = NextTrackButton()
    private let subtitleAudioMenuButton = SubtitleAudioButton()
    private let progressSlider = ProgressSlider()
    private let currentTimeLabel = CurrentTimeLabel()
    private let totalTimeLabel = TotalTimeLabel()
    private var videoNameLabel = VideoNameLabel(text: "")
    private let closeButton = CloseButton()
    var closeView: (() -> Void)?
    private var playerItemObserver: NSKeyValueObservation?
    private let audioMenuTableView = UITableView()
    private let subtitleMenuTableView = UITableView()
    private let closeMenuButton = CloseButton()
    private var audioGroup: AVMediaSelectionGroup?
    private var subtitleGroup: AVMediaSelectionGroup?
    private var audioSelectedIndex = 0
    private var subtitleSelectedIndex = 0
    private var isMenuOpen = false {
        didSet {
            checkIfHideControls()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, player: AVQueuePlayer?, videoQueue: [Video]?) {
        self.init(frame: frame)
        self.player = player
        self.videos = videoQueue
        setup()
        backgroundColor = .black.withAlphaComponent(0.5)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("ControlPanel is deallocated")
    }

    private func setup() {
        addControls()
        setupPlayer()
        setupControls()
        setupPlayerQueue()
        setupClose()
        checkPlayerItemNumber()
    }

    private func convertVideosToPlayerQueue(videoUrls: [String]) -> [AVPlayerItem] {
        var playerQueue: [AVPlayerItem] = []
        videoUrls.forEach {
            guard let url = URL(string: $0) else { return }
            let item = AVPlayerItem(url: url)
            playerQueue.append(item)
        }
        return playerQueue
    }

    private func addControls() {
        addSubview(playPauseButton)
        addSubview(fastForwardButton)
        addSubview(rewindButton)
        addSubview(nextTrackButton)
        addSubview(subtitleAudioMenuButton)
        addSubview(progressSlider)
        addSubview(totalTimeLabel)
        addSubview(currentTimeLabel)
        addSubview(videoNameLabel)
        addSubview(closeButton)
        addSubview(closeMenuButton)
    }

    private func setupPlayer() {
        playPauseButton.player = player
        fastForwardButton.player = player
        rewindButton.player = player
        nextTrackButton.player = player
        progressSlider.player = player
        currentTimeLabel.player = player
        totalTimeLabel.player = player
    }

    private func setupControls() {
        playPauseButton.setup()
        fastForwardButton.setup()
        rewindButton.setup()
        nextTrackButton.setup()
        subtitleAudioMenuButton.setup()
        progressSlider.setup()
        currentTimeLabel.setup()
        totalTimeLabel.setup()
        closeButton.setup()
        closeMenuButton.setup()
        videoNameLabel = VideoNameLabel(text: videos?.first?.name ?? "")
        videoNameLabel.layoutPosition()
        layoutProgressBar()
        addPlayerItemObserver()
        tapSubtitleAudioMenuButton()
        tapCloseMenuButton()
        setupMenuContent()
    }

    private func setupPlayerQueue() {
        guard let videos = videos else {
            return
        }

        let videoUrls: [String] = {
            var videoUrls: [String] = []
            videos.forEach {
                videoUrls.append($0.url)
            }
            return videoUrls
        }()

        playerQueue = convertVideosToPlayerQueue(videoUrls: videoUrls)
        player = AVQueuePlayer(items: playerQueue)
    }

    private func setupMenuContent() {
        subtitleMenuTableView.isHidden = !isMenuOpen
        audioMenuTableView.isHidden = !isMenuOpen
        closeMenuButton.isHidden = !isMenuOpen
    }

    private func tapSubtitleAudioMenuButton() {
        subtitleAudioMenuButton.openMenu = { [weak self] in
            self?.isMenuOpen = true
        }
    }

    private func tapCloseMenuButton() {
        closeMenuButton.closeView = { [weak self] in
            self?.isMenuOpen = false
        }
    }

    private func checkIfHideControls() {
        subtitleMenuTableView.isHidden = !isMenuOpen
        audioMenuTableView.isHidden = !isMenuOpen
        closeMenuButton.isHidden = !isMenuOpen
        playPauseButton.isHidden = isMenuOpen
        rewindButton.isHidden = isMenuOpen
        fastForwardButton.isHidden = isMenuOpen
        nextTrackButton.isHidden = isMenuOpen
        subtitleAudioMenuButton.isHidden = isMenuOpen
        progressSlider.isHidden = isMenuOpen
        currentTimeLabel.isHidden = isMenuOpen
        totalTimeLabel.isHidden = isMenuOpen
        closeButton.isHidden = isMenuOpen
    }

    private func setupClose() {
        closeButton.closeView = { [weak self] in
            self?.closeView?()
        }
    }

    private func addPlayerItemObserver() {
        playerItemObserver = player?.observe(\.currentItem, options: [.new], changeHandler: { [weak self] player, _ in
            self?.totalTimeLabel.setup()
        })
    }

    private func layoutProgressBar() {
        currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        totalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        progressSlider.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            currentTimeLabel.bottomAnchor.constraint(equalTo: nextTrackButton.topAnchor, constant: -12),
            currentTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            totalTimeLabel.bottomAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor),
            totalTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            progressSlider.heightAnchor.constraint(equalToConstant: 32),
            progressSlider.leadingAnchor.constraint(equalTo: currentTimeLabel.trailingAnchor, constant: 16),
            progressSlider.trailingAnchor.constraint(equalTo: totalTimeLabel.leadingAnchor, constant: -16),
            progressSlider.centerYAnchor.constraint(equalTo: currentTimeLabel.centerYAnchor)
        ])
    }

    private func checkPlayerItemNumber() {
        if playerQueue.count <= 1 {
            nextTrackButton.isHidden = true
        }
    }
}
