//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    let viewModel = HomeViewModel()
    let previewImageView = UIImageView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchVideos()

        viewModel.videoViewModels.bind { [weak self] videos in
            self?.previewImageView.image = videos[0].previewImage
        }

        setupPreviewImageView()
    }

    // MARK: - Function
    func setupPreviewImageView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapPreviewImageView(_:)))
        previewImageView.addGestureRecognizer(gesture)
        previewImageView.isUserInteractionEnabled = true
        previewImageView.contentMode = .scaleAspectFill
        previewImageView.layer.cornerRadius = 10.0
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(previewImageView)

        NSLayoutConstraint.activate([
            previewImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            previewImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            previewImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            previewImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func tapPreviewImageView(_ sender: UIGestureRecognizer) {
        let video = viewModel.videoViewModels.value[0].video
        let videoVC = VideoViewController(video: video)
        videoVC.modalPresentationStyle = .overFullScreen
        present(videoVC, animated: true)
    }
}
