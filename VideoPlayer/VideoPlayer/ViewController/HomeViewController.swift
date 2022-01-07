//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    private lazy var playVideoButton: UIButton = {
        let button = UIButton()
        button.setTitle("播放影片", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(tapPlayButton(_:)), for: .touchUpInside)
        return button
    }()

    let videos = [
        Video(name: VideoResource.getName(.firstVideo),
              url: VideoResource.getUrl(.firstVideo)),
        Video(name: VideoResource.getName(.secondVideo),
              url: VideoResource.getUrl(.secondVideo))
    ]

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayVideoButton()
    }

    // MARK: - Function
    func setupPlayVideoButton() {
        view.addSubview(playVideoButton)
        playVideoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playVideoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playVideoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func tapPlayButton(_ sender: UIButton) {
        let videoVC = VideoViewController(videos: videos)
        videoVC.modalPresentationStyle = .overFullScreen
        present(videoVC, animated: true)
    }
}
