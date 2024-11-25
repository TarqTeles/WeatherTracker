//
//  HTTPClient.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to the appropriate threads, if needed.
    func get(from url: URL) async -> HTTPClient.Result
}
