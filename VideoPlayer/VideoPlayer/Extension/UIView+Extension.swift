//
//  UIView+Extension.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import UIKit

extension UIView {

    func stickSubView(_ subView: UIView, toSafe alignSafeAreaLayoutGuide: Bool) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false

        let viewTopAnchor = alignSafeAreaLayoutGuide
        ? safeAreaLayoutGuide.topAnchor : topAnchor
        let viewBottomAnchor = alignSafeAreaLayoutGuide
        ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor
        let viewLeadingAnchor = alignSafeAreaLayoutGuide
        ? safeAreaLayoutGuide.leadingAnchor : leadingAnchor
        let viewTrailingAnchor = alignSafeAreaLayoutGuide
        ? safeAreaLayoutGuide.trailingAnchor : trailingAnchor

        subView.topAnchor.constraint(equalTo: viewTopAnchor).isActive = true
        subView.bottomAnchor.constraint(equalTo: viewBottomAnchor).isActive = true
        subView.leadingAnchor.constraint(equalTo: viewLeadingAnchor).isActive = true
        subView.trailingAnchor.constraint(equalTo: viewTrailingAnchor).isActive = true
    }
}
