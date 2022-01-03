//
//  ListCollectionViewCell.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import Foundation
import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var videoNameLabel: UILabel!

    private var viewModel: VideoViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        previewImageView.clipsToBounds = true
    }

    func layoutCell(viewModel: VideoViewModel) {

        self.viewModel = viewModel
        layoutCell()
    }

    private func layoutCell() {

        guard let viewModel = viewModel else {
            return
        }
        previewImageView.image = viewModel.previewImage
        videoNameLabel.text = viewModel.name
    }
}
