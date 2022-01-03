//
//  VideoViewModel.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import Foundation
import UIKit

class VideoViewModel {

    var video: Video

    init(_ video: Video) {
        self.video = video
    }

    var name: String {
        return video.name
    }

    var url: String {
        return video.url
    }

    var previewImage: UIImage {
        return video.previewImage
    }
}
