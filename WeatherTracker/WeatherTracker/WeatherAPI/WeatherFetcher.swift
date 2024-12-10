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
    var iconCache = WeatherIconCache()
    
    private var activeTaskGroup: ThrowingTaskGroup<WeatherViewModel, any Error>?

    init(client: HTTPClient, viewModel: MainViewModel) {
        self.client = client
        self.viewModel = viewModel
    }
    
    class InvalidResponseError: Error {}
    class FetchingCancelledError: Error {}

    public func getLocations(for loc: String) async throws {
        await MainActor.run { self.viewModel.availableLocations = [] }
        activeTaskGroup?.cancelAll()
        
        let fetchURL = WeatherEndpoint.locations(for: loc)
        
        let result = await client.get(from: fetchURL)

        switch result {
            case let .success((data, response)):
                guard response.statusCode == isOK200 else { throw InvalidResponseError() }
                do {
                    let locations = try Locations(data: data)
                    try await withThrowingTaskGroup(of: WeatherViewModel.self) { group in
                        self.activeTaskGroup = group
                        
                        for location in locations {
                            guard !group.isCancelled else { break }
                            group.addTask {
                                return try await self.getCurrentWeather(for: location)
                            }
                        }
                        for try await weather in group {
                            await MainActor.run { self.viewModel.availableLocations.append(weather) }
                        }
                    }
                    activeTaskGroup = nil
                } catch {
                    throw error
                }
            case let .failure(error):
                throw error
        }
    }
    
    public func getCurrentWeather(for location: Location) async throws -> WeatherViewModel {
        try await getCurrentWeather(for: location.name)
    }
    
    public func getCurrentWeather(for loc: String) async throws -> WeatherViewModel {
        guard !Task.isCancelled else { throw FetchingCancelledError() }
        let fetchURL = WeatherEndpoint.currentWeather(for: loc)
        
        let result = await client.get(from: fetchURL)
        
        switch result {
            case let .success((data, response)):
                guard response.statusCode == isOK200 else { throw InvalidResponseError() }
                do {
                    let currentWeather = try CurrentWeather(data: data)
                    let image = try await getIconUsingCacheIfAvailable(for: currentWeather.current.condition)
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
    
    private func getIconUsingCacheIfAvailable(for condition: Condition) async throws -> Image {
        guard let img = await iconCache.cachedIconImage(for: condition.icon) else {
            return try await getIconFromServer(for: condition)
        }
        return img
    }
    
    private func getIconFromServer(for condition: Condition) async throws -> Image {
        guard let fetchURL = URL(string: "https:" + condition.icon) else {
            return await iconCache.iconImage(for: "")
        }
        let result = await client.get(from: fetchURL)
        
        switch result {
            case let .success((data, response)):
                guard response.statusCode == isOK200 else { throw InvalidResponseError() }
                return await iconCache.imageFrom(data: data, cachingTo: condition)
            case let .failure(error):
                throw error
        }
    }

    private let isOK200 = 200
}
