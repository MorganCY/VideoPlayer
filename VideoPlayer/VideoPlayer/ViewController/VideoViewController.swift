//
//  VideoViewController.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: - Properties
    var videos: [Video]
    var player: AVQueuePlayer?
    var playerLayer: AVPlayerLayer?
    var controlPanel: ControlPanelView?
    var playerQueue: [AVPlayerItem] = []

    // Limit orientation to landscape only
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var shouldAutorotate: Bool {
        return true
    }

    // MARK: - Initializer
    // Designated initializer making sure there's a video passed in when being instantiated
    init(videos: [Video]) {
        self.videos = videos
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupPlayerQueue()
        setupPlayer(playQueue: playerQueue)
        setupControlPanel()
        handleTapOnView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.safeAreaLayoutGuide.layoutFrame
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeFirstItemEndPlaying()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
    }

    // MARK: - Functions
    private func setupPlayer(playQueue: [AVPlayerItem]) {
        player = AVQueuePlayer(items: playerQueue)
        player?.rate = 1
        playerLayer = AVPlayerLayer(player: player)
        view.layer.addSublayer(playerLayer!)
    }

    private func observeFirstItemEndPlaying() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerHideNextTrack),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.items().first
        )
    }

    @objc private func playerHideNextTrack() {
        controlPanel?.nextTrackButton.isHidden = true
        NotificationCenter.default.removeObserver(
            self,
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.items().first
        )
        observeLastItemEndPlaying()
    }

    private func observeLastItemEndPlaying() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidEndPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.items().last
        )
    }

    @objc private func playerDidEndPlaying() {
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.removeObserver(
            self,
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.items().last
        )
    }

    private func setupControlPanel() {
        controlPanel = ControlPanelView(frame: view.frame, player: player, videoQueue: videos)

        guard let controlPanel = controlPanel else {
            return
        }
        view.stickSubView(controlPanel, toSafe: false)
        controlPanel.isHidden = true
        controlPanel.closeView = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        controlPanel.nextTrackButton.nextTrackHandler = { [weak self] in
            self?.observeLastItemEndPlaying()
        }
    }

    private func setupPlayerQueue() {
        let videoUrls: [String] = {
            var videoUrls: [String] = []
            videos.forEach {
                videoUrls.append($0.url)
            }
            return videoUrls
        }()

        playerQueue = convertVideosToPlayerQueue(videoUrls: videoUrls)
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

    private func handleTapOnView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        view.addGestureRecognizer(gesture)
        controlPanel?.gestureHandler = { isMenuOpen in
            gesture.isEnabled = !isMenuOpen
        }
    }

    @objc private func tapped(_ sender: UITapGestureRecognizer) {
        controlPanel?.isHidden.toggle()
    }
}
