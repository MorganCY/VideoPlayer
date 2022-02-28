//
//  ControlPanel.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/6.
//

import Foundation
import UIKit
import AVKit

class ControlPanelView: UIView {

    // MARK: - Player Information
    private var videos: [Video]?
    private var player: AVQueuePlayer?
    private var playerQueue: [AVPlayerItem] = []
    var audioGroup: AVMediaSelectionGroup? {
        didSet {
            audioOptionMenu.reloadData()
        }
    }
    var subtitleGroup: AVMediaSelectionGroup? {
        didSet {
            subtitleOptionMenu.reloadData()
        }
    }
    var audioOptionIndex = 0 {
        didSet {
            guard let audioGroup = audioGroup else {
                return
            }
            audioOptionMenu.reloadData()
            player?.currentItem?.select(audioGroup.options[audioOptionIndex], in: audioGroup)
        }
    }
    var subtitleOptionIndex = 0 {
        didSet {
            guard let subtitleGroup = subtitleGroup else {
                return
            }
            subtitleOptionMenu.reloadData()
            player?.currentItem?.select(subtitleGroup.options[subtitleOptionIndex], in: subtitleGroup)
        }
    }

    // MARK: - Player Controls
    private let playPauseButton = PlayPauseButton()
    private let fastForwardButton = ChangeTimeButton(fastForward: true)
    private let rewindButton = ChangeTimeButton(fastForward: false)
    private let subtitleAudioMenuButton = SubtitleAudioButton()
    private let progressSlider = ProgressSlider()
    private let currentTimeLabel = CurrentTimeLabel()
    private let totalTimeLabel = TotalTimeLabel()
    private let closePanelButton = CloseButton()
    let nextTrackButton = NextTrackButton()
    let closeMenuButton = CloseButton()
    let audioOptionMenu = UITableView()
    let subtitleOptionMenu = UITableView()
    let menuStackView = UIStackView()
    var isMenuOpen = false {
        didSet {
            checkIfHideControls()
        }
    }
    var closeView: (() -> Void)?
    var gestureHandler: ((Bool) -> Void)?
    private var playerItemObserver: NSKeyValueObservation?

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, player: AVQueuePlayer?, videoQueue: [Video]?) {
        self.init(frame: frame)
        self.player = player
        self.videos = videoQueue
        setup()
        backgroundColor = .black.withAlphaComponent(0.7)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    private func setup() {
        addControls()
        setupPlayer()
        setupControls()
        setupPlayerQueue()
        setupSubtitleAudioGroup()
        setupMenu()
        checkIfHideNextTrackButton()
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

    // 可以一次map玩
    private func convertVideosToPlayerQueue(videoUrls: [String]) -> [AVPlayerItem] {
        var playerQueue: [AVPlayerItem] = []
        videoUrls.forEach {
            guard let url = URL(string: $0) else { return }
            let item = AVPlayerItem(url: url)
            playerQueue.append(item)
        }
        return playerQueue
    }

    private func setupSubtitleAudioGroup() {
        guard let asset = player?.currentItem?.asset else {
            return
        }
        if let group = asset.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristic.audible) {
            audioGroup = group
        }
        if let group = asset.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristic.legible) {
            subtitleGroup = group
        }
    }

    private func setupTotalTimeLabel() {
        playerItemObserver = player?.observe(\.currentItem, options: [.new], changeHandler: { [weak self] player, _ in
            self?.totalTimeLabel.setup()
        })
    }

    private func tapSubtitleAudioMenuButton() {
        subtitleAudioMenuButton.openMenu = { [weak self] in
            self?.isMenuOpen = true
        }
    }

    private func tapClosePanelButton() {
        closePanelButton.closeView = { [weak self] in
            self?.closeView?()
        }
    }

    private func tapCloseMenuButton() {
        closeMenuButton.closeView = { [weak self] in
            self?.isMenuOpen = false
        }
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
        addSubview(closePanelButton)
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
        setupTotalTimeLabel()
        totalTimeLabel.setup()
        closePanelButton.setup(image: .closePanel)
        closeMenuButton.setup(image: .closeMenu)
        layoutProgressBar()
        tapSubtitleAudioMenuButton()
        tapClosePanelButton()
        tapCloseMenuButton()
    }

    private func checkIfHideControls() {
        menuStackView.isHidden = !isMenuOpen
        closeMenuButton.isHidden = !isMenuOpen
        playPauseButton.isHidden = isMenuOpen
        rewindButton.isHidden = isMenuOpen
        fastForwardButton.isHidden = isMenuOpen
        nextTrackButton.isHidden = isMenuOpen
        subtitleAudioMenuButton.isHidden = isMenuOpen
        progressSlider.isHidden = isMenuOpen
        currentTimeLabel.isHidden = isMenuOpen
        totalTimeLabel.isHidden = isMenuOpen
        closePanelButton.isHidden = isMenuOpen
        gestureHandler?(isMenuOpen)
    }

    private func checkIfHideNextTrackButton() {
        if player?.currentItem == player?.items().last {
            nextTrackButton.isHidden = true
        }
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
}
