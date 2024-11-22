//
//  WeatherFetcher.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import Foundation

public final class WeatherFetcher {
    let client: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    var chosenLocation: Location?
    var availableLocations = Locations()
    
    public func getLocations(for loc: String) async throws {
        let fetchURL = WeatherEndpoint.locations(for: loc)
        
        let result = await client.get(from: fetchURL)
        
        switch result {
            case let .success((data, response)):
                do {
                    availableLocations = try Locations(data: data)
                } catch {
                    throw error
                }
            case let .failure(error):
                throw error
        }
    }
}
