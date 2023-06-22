//
//  NetworkMonitor.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 22.06.2023.
//
import Network

public protocol NetworkMonitorDelegate {
    func networkStatusChange(status:Bool)
}

public class NetworkMonitor {
    public static let shared = NetworkMonitor()
    public var delegate:NetworkMonitorDelegate?

    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true

    public func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive

            self?.delegate?.networkStatusChange(status: path.status == .satisfied)
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    public func stopMonitoring() {
        monitor.cancel()
    }
}
