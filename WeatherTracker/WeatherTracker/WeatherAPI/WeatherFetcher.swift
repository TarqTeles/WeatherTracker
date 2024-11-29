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
    var cachedIcons = [String : Data]()
    var iconCalls = 0

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
        DispatchQueue.main.async { [self, weathers] in
            viewModel.availableLocations = weathers
        }
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
        guard let imgData = cachedIcons[condition.icon] else {
            return try await getIconFromServer(for: condition)
        }
        iconCalls += 1
        print("prevented \(iconCalls) icon calls!")
        return imageFrom(data: imgData)
    }
    
    private func getIconFromServer(for condition: Condition) async throws -> Image {
        if let fetchURL = URL(string: "https:" + condition.icon) {
            let result = await client.get(from: fetchURL)
            
            switch result {
                case let .success((data, response)):
                    guard response.statusCode == isOK200 else { throw InvalidResponseError() }
                    return imageFrom(data: data, cachingTo: condition)
                case let .failure(error):
                    throw error
            }

        } else {
            return missingIcon
        }
    }

    private func imageFrom(data: Data, cachingTo condition: Condition) -> Image {
        let image = imageFrom(data: data)
        if image != missingIcon {
            cachedIcons[condition.icon] = data
        }
        return image
    }

    private func imageFrom(data: Data) -> Image {
        if let uiImg = UIImage(data: data) {
            return Image(uiImage: uiImg)
        } else {
            return missingIcon
        }
    }
    
    private let isOK200 = 200
    private let missingIcon = Samples.missingIconImage
}
