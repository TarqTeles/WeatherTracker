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
    
    public struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask
        
        public func cancel() {
            wrapped.cancel()
        }
    }
    
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: url) {data , response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedErrorRepresentation()
                }
            })
        }
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
    
    public func get(from url: URL) async -> HTTPClient.Result {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return .success((data, response as! HTTPURLResponse))
        } catch {
            return .failure(error)
        }
    }
}
