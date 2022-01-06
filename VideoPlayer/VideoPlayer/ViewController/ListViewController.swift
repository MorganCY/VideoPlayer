//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import Foundation
import UIKit

class ListViewController: UIViewController {

    // MARK: - Properties
    let tableView = UITableView()
    let videos = [
        Video(name: VideoResource.getName(.firstVideo),
              url: VideoResource.getUrl(.firstVideo),
              previewImage: UIImage.asset(.firstVideo)),
        Video(name: VideoResource.getName(.secondVideo),
              url: VideoResource.getUrl(.secondVideo),
              previewImage: UIImage.asset(.secondVideo))
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
        setupTableView()
    }

    // MARK: - Function
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: String(describing: ListTableViewCell.self))
        tableView.backgroundColor = .clear
        view.stickSubView(tableView, toSafe: true)
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListTableViewCell.self), for: indexPath)

        guard let listCell = cell as? ListTableViewCell else {
            return cell
        }
        listCell.layoutCell(video: videos[indexPath.row])
        return listCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let videoVC: VideoViewController = {
            if indexPath.row == 0 {
                return VideoViewController(videos: videos)
            } else {
                return VideoViewController(videos: [videos[indexPath.row]])
            }
        }()
        videoVC.modalPresentationStyle = .overFullScreen
        present(videoVC, animated: true)
    }
}
