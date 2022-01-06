//
//  ListTableViewCell.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/6.
//

import Foundation
import UIKit

class ListTableViewCell: UITableViewCell {

    let previewImageView = UIImageView()
    let videoNameBackgroundView = UIView()
    let videoNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViews() {
        contentView.addSubview(previewImageView)
        contentView.addSubview(videoNameBackgroundView)
        contentView.addSubview(videoNameLabel)
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        videoNameBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        videoNameLabel.translatesAutoresizingMaskIntoConstraints = false

        previewImageView.contentMode = .scaleAspectFit
        previewImageView.clipsToBounds = true
        videoNameBackgroundView.backgroundColor = .gray
        videoNameLabel.textColor = .white
        backgroundColor = .clear

        NSLayoutConstraint.activate([
            previewImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            previewImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            previewImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            previewImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            videoNameBackgroundView.heightAnchor.constraint(equalTo: previewImageView.heightAnchor, multiplier: 0.15),
            videoNameBackgroundView.widthAnchor.constraint(equalTo: previewImageView.widthAnchor),
            videoNameBackgroundView.leadingAnchor.constraint(equalTo: previewImageView.leadingAnchor),
            videoNameBackgroundView.bottomAnchor.constraint(equalTo: previewImageView.bottomAnchor),
            videoNameLabel.centerYAnchor.constraint(equalTo: videoNameBackgroundView.centerYAnchor),
            videoNameLabel.leadingAnchor.constraint(equalTo: videoNameBackgroundView.leadingAnchor, constant: 8)
        ])
    }

    func layoutCell(video: Video) {
        previewImageView.image = video.previewImage
        videoNameLabel.text = video.name
    }
}
