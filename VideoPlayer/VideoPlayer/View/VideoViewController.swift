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

class VideoViewController: UIViewController {

    // MARK: - Properties
    var video: Video
    var player: AVPlayer?
    let playPauseButton = PlayPauseButton()
    let fastForwardButton = TimeChangingButton(fastForward: true)
    let rewindButton = TimeChangingButton(fastForward: false)
    let dimmingView = UIView()

    // Limit orientation to landscape only
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Initializer
    // Designated initializer making sure there's a video passed in when being instantiated
    init(video: Video) {
        self.video = video
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer(videoPath: video.url)
        setupControlPanel()
        view.backgroundColor = .black
    }

    // MARK: - Function
    func setupPlayer(videoPath: String) {
        guard let url = URL(string: video.url) else { return }

        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)

        player = AVPlayer(playerItem: item)

        /// Play the video automatically
        player?.rate = 1

        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        view.stickSubView(playerViewController.view, toSafe: true)

        /// Hide native controls of AVPlayer
        playerViewController.showsPlaybackControls = false

        addChild(playerViewController)
        playerViewController.didMove(toParent: self)
        playPauseButton.avPlayer = player
        fastForwardButton.avPlayer = player
        rewindButton.avPlayer = player
    }

    func setupControlPanel() {
        let videoNameLabel = VideoNameLabel(text: video.name)
        let closeButton = CloseButton()
        let controls = [videoNameLabel, closeButton, playPauseButton, fastForwardButton, rewindButton]

        view.stickSubView(dimmingView, toSafe: false)
        dimmingView.isHidden = true
        dimmingView.backgroundColor = .black.withAlphaComponent(0.5)

        controls.forEach { dimmingView.addSubview($0) }

        playPauseButton.setup()
        closeButton.setup()
        videoNameLabel.layoutPosition()
        fastForwardButton.setup()
        rewindButton.setup()

        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        view.addGestureRecognizer(gesture)
        closeButton.closeView = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            self?.player?.replaceCurrentItem(with: nil)
        }
    }

    @objc func tapped(_ sender: UITapGestureRecognizer) {
        dimmingView.isHidden.toggle()
    }
}
