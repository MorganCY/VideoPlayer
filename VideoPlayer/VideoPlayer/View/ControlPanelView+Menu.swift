//
//  ControlPanelView+MenuTableView.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/7.
//

import Foundation
import UIKit

extension ControlPanelView: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case audioOptionMenu:
            return audioGroup?.options.count ?? 0
        case subtitleOptionMenu:
            return subtitleGroup?.options.count ?? 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuTableViewCell.self), for: indexPath)

        guard let optionCell = cell as? MenuTableViewCell else { return cell }

        switch tableView {
        case audioOptionMenu:
            optionCell.layoutCellLabel(with: audioGroup?.options[indexPath.row].displayName ?? "")

            if indexPath.row == audioOptionIndex {
                optionCell.accessoryType = .checkmark
            } else {
                optionCell.accessoryType = .none
            }
        case subtitleOptionMenu:
            optionCell.layoutCellLabel(with: subtitleGroup?.options[indexPath.row].displayName ?? "")

            if indexPath.row == subtitleOptionIndex {
                optionCell.accessoryType = .checkmark
            } else {
                optionCell.accessoryType = .none
            }
        default:
            break
        }
        optionCell.tintColor = .white

        return optionCell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: MenuTableViewHeader.self))

        guard let titleHeader = header as? MenuTableViewHeader else {
            return header
        }

        switch tableView {
        case audioOptionMenu:
            titleHeader.layouLabel(with: "音訊")
        case subtitleOptionMenu:
            titleHeader.layouLabel(with: "字幕")
        default:
            break
        }
        return titleHeader
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case audioOptionMenu:
            audioOptionIndex = indexPath.row
        case subtitleOptionMenu:
            subtitleOptionIndex = indexPath.row
        default:
            break
        }
    }

    // MARK: - Setup Menu
    func setupMenu() {
        let menus = [audioOptionMenu, subtitleOptionMenu]
        menuStackView.isHidden = !isMenuOpen
        closeMenuButton.isHidden = !isMenuOpen
        addSubview(menuStackView)
        menuStackView.translatesAutoresizingMaskIntoConstraints = false
        menuStackView.axis = .horizontal
        menuStackView.spacing = 12
        menus.forEach {
            menuStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.dataSource = self
            $0.delegate = self
            $0.backgroundColor = .clear
            $0.separatorColor = .white
            $0.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identifier)
            $0.registerHeaderWithNib(identifier: MenuTableViewHeader.identifier, bundle: nil)
        }
        
        NSLayoutConstraint.activate([
            menuStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            menuStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            menuStackView.trailingAnchor.constraint(equalTo: closeMenuButton.leadingAnchor, constant: -16),
            menuStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            audioOptionMenu.leadingAnchor.constraint(equalTo: menuStackView.leadingAnchor),
            audioOptionMenu.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            subtitleOptionMenu.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3)
        ])
    }
}
