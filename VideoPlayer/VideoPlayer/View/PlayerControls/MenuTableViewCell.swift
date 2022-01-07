//
//  MenuTableViewCell.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/7.
//

import Foundation
import UIKit

class MenuTableViewCell: UITableViewCell {

    let optionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupLabel() {
        contentView.addSubview(optionLabel)
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        optionLabel.textColor = .white
        optionLabel.font = UIFont.systemFont(ofSize: 14)
        optionLabel.numberOfLines = 1
        NSLayoutConstraint.activate([
            optionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            optionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            optionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            optionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)])
    }

    func layoutCellLabel(with displayName: String) {
        optionLabel.text = displayName
    }
}
