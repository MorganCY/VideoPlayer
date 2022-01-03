//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import UIKit

class ListViewController: UIViewController {

    // MARK: - Properties
    let viewModel = ListViewModel()
    let tableView = UITableView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchVideos()

        setupTableView()

        /// Reload table view when video data is updated
        viewModel.videoViewModels.bind { [weak self] _ in
            self?.viewModel.onRefresh()
        }

        viewModel.refreshView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Function
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.registerCellWithNib(identifier: ListTableViewCell.identifier, bundle: nil)
        view.stickSubView(tableView)
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.videoViewModels.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath)

        guard let videoCell = cell as? ListTableViewCell else {
            return cell
        }

        let cellViewModel = viewModel.videoViewModels.value[indexPath.row]

        videoCell.layoutCell(viewModel: cellViewModel)

        return videoCell
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = viewModel.videoViewModels.value[indexPath.row].url
        let videoVC = VideoViewController(videoPath: url)
        videoVC.modalPresentationStyle = .overFullScreen
        present(videoVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.height * 0.25
    }
}
