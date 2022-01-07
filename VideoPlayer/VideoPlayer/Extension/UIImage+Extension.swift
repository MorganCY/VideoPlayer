//
//  UIImage+Extension.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import Foundation
import UIKit

enum ImageAsset: String {

    case play = "playButton"
    case pause = "pauseButton"
    case fastForward = "fastForwardButton"
    case rewind = "rewindButton"
    case closePanel = "closePanelButton"
    case closeMenu = "closeMenuButton"
    case next = "nextTrack"
    case menu = "menuButton"
}

extension UIImage {

    static func asset(_ asset: ImageAsset) -> UIImage {

        return UIImage(named: asset.rawValue) ?? UIImage()
    }
}
