//
//  NetworkMonitor.swift
//  MarvelApp
//
//  Created by jescobar on 7/28/22.
//

import Foundation
import Network

class NetworkMonitor: ObservableObject {
    @Published var isConnected = false
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue

    init(
        monitor: NWPathMonitor,
        queue: DispatchQueue
    ) {
        self.monitor = monitor
        self.queue = queue
    }

    convenience init() {
        self.init(
            monitor: .init(),
            queue: .init(label: "NetworkMonitor")
        )
        self.startChecking()
    }

    private func startChecking() {
        debugPrint("NetworkMonitor", #function)
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.pathHandler(path: path)
            }
        }
    }

    private func pathHandler(path: NWPath) {
        debugPrint("NetworkMonitor status:", path.status)
        switch path.status {
        case .satisfied:
            isConnected = true
        default:
            isConnected = false
        }
    }

    deinit {
        debugPrint("NetworkMonitor", #function)
        monitor.cancel()
    }
}

#if DEBUG
extension NetworkMonitor {
    convenience init(isConnected: Bool) {
        self.init(
            monitor: .init(),
            queue: .init(label: "MockNetworkMonitor")
        )
        self.isConnected = isConnected
    }
}
#endif
