//
//  VideoUrl.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import Foundation

enum VideoResource: String {

    case firstVideo
    case secondVideo

    static func getName(_ asset: VideoResource) -> String {

        let name: String

        switch asset {
        case .firstVideo:
            name = "First Video"
        case .secondVideo:
            name = "Second Video"
        }

        return name
    }

    static func getUrl(_ asset: VideoResource) -> String {

        let url: String

        switch asset {
        case .firstVideo:
            url = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
        case .secondVideo:
            url =  "http://devimages.apple.com.edgekey.net/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8"
        }

        return url
    }
}
