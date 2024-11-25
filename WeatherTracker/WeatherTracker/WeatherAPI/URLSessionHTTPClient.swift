//
//  URLSessionHTTPClient.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private struct UnexpectedErrorRepresentation: Error {}
        
    public func get(from url: URL) async -> HTTPClient.Result {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return .success((data, response as! HTTPURLResponse))
        } catch {
            return .failure(error)
        }
    }
}
