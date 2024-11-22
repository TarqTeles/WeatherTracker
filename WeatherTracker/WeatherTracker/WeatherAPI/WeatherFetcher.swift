//
//  WeatherFetcher.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import Foundation

public final class WeatherFetcher {
    let client: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    var chosenLocation: WeatherLocation?
    var availableLocations = Locations()
    var currentWeather: Current?

    class InvalidResponseError: Error {}
    
    public func getLocations(for loc: String) async throws {
        let fetchURL = WeatherEndpoint.locations(for: loc)
        
        let result = await client.get(from: fetchURL)
        
        switch result {
            case let .success((data, response)):
                guard response.statusCode == isOK200 else { throw InvalidResponseError() }
                do {
                    availableLocations = try Locations(data: data)
                } catch {
                    throw error
                }
            case let .failure(error):
                throw error
        }
    }
    
    public func getCurrentWeather(for location: WeatherLocation) async throws {
        try await getCurrentWeather(for: location.name)
    }
    
    public func getCurrentWeather(for loc: String) async throws {
        let fetchURL = WeatherEndpoint.currentWeather(for: loc)
        
        let result = await client.get(from: fetchURL)
        
        switch result {
            case let .success((data, response)):
                guard response.statusCode == isOK200 else { throw InvalidResponseError() }
                do {
                    let weather = try CurrentWeather(data: data)
                    currentWeather = weather.current
                } catch {
                    throw error
                }
            case let .failure(error):
                throw error
        }
    }
    
    private let isOK200 = 200
}
