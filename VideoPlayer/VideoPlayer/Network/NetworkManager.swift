//
//  NetworkManager.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/7.
//

import Network

typealias NoConnectionHandler = () -> Void

class NetworkManager {

    let monitor = NWPathMonitor()

    func checkNetworkStatus(noConnectionHandler: @escaping NoConnectionHandler) {
        monitor.pathUpdateHandler = { path in
           if path.status == .satisfied {
              print("connected")
           } else {
              noConnectionHandler()
           }
        }
        monitor.start(queue: DispatchQueue.global())
    }
}
