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
    let dimmingView = UIView()

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

        player = AVPlayer(url: url)

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
    }

    func setupControlPanel() {
        let videoNameLabel = VideoNameLabel(text: video.name)
        let closeButton = CloseButton()
        let controls = [videoNameLabel, closeButton, playPauseButton]

        view.stickSubView(dimmingView, toSafe: false)
        dimmingView.isHidden = true
        dimmingView.backgroundColor = .black.withAlphaComponent(0.5)

        controls.forEach { dimmingView.addSubview($0) }

        playPauseButton.setup()
        closeButton.setup()
        videoNameLabel.layoutPosition()

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
