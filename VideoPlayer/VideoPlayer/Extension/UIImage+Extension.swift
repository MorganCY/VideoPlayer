//
//  UIImage+Extension.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import Foundation
import UIKit

enum ImageAsset: String {

    case firstVideo = "FirstVideo"
    case secondVideo = "SecondVideo"
}

extension UIImage {

    static func asset(_ asset: ImageAsset) -> UIImage {

        return UIImage(named: asset.rawValue) ?? UIImage()
    }
}
