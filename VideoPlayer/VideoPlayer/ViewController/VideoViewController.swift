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
    var videoQueue: [Video]
    var player: AVPlayer?
    var controlPanel: ControlPanelView?

    // Limit orientation to landscape only
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Initializer
    // Designated initializer making sure there's a video passed in when being instantiated
    init(videoQueue: [Video]) {
        self.videoQueue = videoQueue
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer(videoPath: videoQueue[0].url)
        view.backgroundColor = .black
    }

    // MARK: - Function
    func setupPlayer(videoPath: String) {
        guard let url = URL(string: videoPath) else { return }

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

        controlPanel = ControlPanelView(frame: view.frame, player: player, videoQueue: videoQueue)

        guard let controlPanel = controlPanel else {
            return
        }

        view.stickSubView(controlPanel, toSafe: true)
        controlPanel.isHidden = true

        controlPanel.closeView = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }

        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        view.addGestureRecognizer(gesture)
    }

    @objc func tapped(_ sender: UITapGestureRecognizer) {
        controlPanel?.isHidden.toggle()
    }
}
