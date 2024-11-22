//
//  WeatherFetcher.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import Foundation
import SwiftUI

public final class WeatherFetcher {
    let client: HTTPClient
    let viewModel: MainViewModel

    init(client: HTTPClient, viewModel: MainViewModel) {
        self.client = client
        self.viewModel = viewModel
    }
    
    class InvalidResponseError: Error {}
    
    public func getLocations(for loc: String) async throws {
        let fetchURL = WeatherEndpoint.locations(for: loc)
        
        let result = await client.get(from: fetchURL)
        var weathers = [WeatherViewModel]()

        switch result {
            case let .success((data, response)):
                guard response.statusCode == isOK200 else { throw InvalidResponseError() }
                do {
                    let locations = try Locations(data: data)
                    for location in locations {
                        let vm = try await getCurrentWeather(for: location)
                        weathers.append(vm)
                    }
                } catch {
                    throw error
                }
            case let .failure(error):
                throw error
        }
        viewModel.availableLocations = weathers
    }
    
    public func getCurrentWeather(for location: Location) async throws -> WeatherViewModel {
        try await getCurrentWeather(for: location.name)
    }
    
    public func getCurrentWeather(for loc: String) async throws -> WeatherViewModel {
        let fetchURL = WeatherEndpoint.currentWeather(for: loc)
        
        let result = await client.get(from: fetchURL)
        
        switch result {
            case let .success((data, response)):
                guard response.statusCode == isOK200 else { throw InvalidResponseError() }
                do {
                    let currentWeather = try CurrentWeather(data: data)
                    let image = Image(systemName: "photo")
                    print("preparing viewModel for \(currentWeather.location.name)")
                    return WeatherViewModel(currentWeather: currentWeather, icon: image)
                } catch {
                    print(String(data: data, encoding: .utf8) ?? "problem decoding JSON")
                    throw error
                }
            case let .failure(error):
                throw error
        }
    }
    
    private let isOK200 = 200
}
