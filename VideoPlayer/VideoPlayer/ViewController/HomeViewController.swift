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
    let networkManager = NetworkManager()
    let playVideoButton = UIButton()
    let videos = [
        Video(name: VideoResource.getName(.firstVideo),
              url: VideoResource.getUrl(.firstVideo)),
        Video(name: VideoResource.getName(.secondVideo),
              url: VideoResource.getUrl(.secondVideo))
    ]

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return true
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNetworkStatus()
        setupPlayVideoButton()
    }

    // MARK: - Functions
    private func checkNetworkStatus() {
        networkManager.checkNetworkStatus {
            let alert = UIAlertController(title: "網路狀態異常", message: "請檢查網路連線狀態", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    private func setupPlayVideoButton() {
        view.addSubview(playVideoButton)
        playVideoButton.translatesAutoresizingMaskIntoConstraints = false
        playVideoButton.setTitle("播放影片", for: .normal)
        playVideoButton.setTitleColor(.black, for: .normal)
        playVideoButton.backgroundColor = .white
        playVideoButton.addTarget(self, action: #selector(tapPlayVideoButton(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            playVideoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playVideoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func tapPlayVideoButton(_ sender: UIButton) {
        let videoVC = VideoViewController(videos: videos)
        videoVC.modalPresentationStyle = .overFullScreen
        present(videoVC, animated: true)
    }
}
