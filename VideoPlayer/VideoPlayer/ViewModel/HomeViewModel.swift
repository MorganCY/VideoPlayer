//
//  ListViewModel.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import Foundation
import UIKit

class HomeViewModel {

    let videoViewModels = Box([VideoViewModel]())

    let videos = [
        Video(name: VideoResource.getName(.firstVideo),
              url: VideoResource.getUrl(.firstVideo),
              previewImage: UIImage.asset(.firstVideo)),
        Video(name: VideoResource.getName(.secondVideo),
              url: VideoResource.getUrl(.secondVideo),
              previewImage: UIImage.asset(.secondVideo))
    ]

    func fetchVideos() {
        setVideoList(videos)
    }

    func setVideoList(_ videos: [Video]) {
        videoViewModels.value = convertUsersToViewModels(from: videos)
    }

    func convertUsersToViewModels(from videos: [Video]) -> [VideoViewModel] {
        var viewModels = [VideoViewModel]()
        for video in videos {
            let viewModel = VideoViewModel(video)
            viewModels.append(viewModel)
        }
        return viewModels
    }
}
