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

        if alignSafeAreaLayoutGuide {
            subView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            subView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
            subView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
            subView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            subView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            subView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            subView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            subView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }
}
