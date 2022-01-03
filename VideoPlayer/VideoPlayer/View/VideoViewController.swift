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
    var videoUrl: String
    var dimmingView = UIView()

    // MARK: - Initializer
    // Designated initializer which makes sure there's a video url passed into VC when being instantiated
    init(videoPath: String) {
        self.videoUrl = videoPath
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer(videoPath: videoUrl)
    }

    // MARK: - Function
    func setupPlayer(videoPath: String) {
        guard let url = URL(string: videoPath) else {
            return
        }

        let asset = AVURLAsset(url: url, options: nil)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)

        /// Play the video automatically
        player.rate = 1

        let playerFrame = CGRect(x: 0, y: 0,
                                 width: view.frame.width,
                                 height: view.frame.height)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.view.frame = playerFrame

        /// Hide controls of AVPlayer
        playerViewController.showsPlaybackControls = false

        addChild(playerViewController)
        view.addSubview(playerViewController.view)
        playerViewController.didMove(toParent: self)
    }
}
