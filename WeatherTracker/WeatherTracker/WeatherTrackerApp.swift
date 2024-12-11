//
//  WeatherTrackerApp.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import SwiftUI

@main
struct WeatherTrackerApp: App {
    let client: HTTPClient
    let main: MainViewModel
    let fetcher: WeatherFetcher
    
    @AppStorage("selectedLocation") var selectedLocation: Data = Data()

    init() {
        client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        main = MainViewModel()
        fetcher = WeatherFetcher(client: client, viewModel: main)
        
        main.setSelectedCity = setSelectedCity(_:)
        main.getLocationsFor = refreshLocations
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(main: main)
                .task {
                    if let city = try? JSONDecoder().decode(Location.self, from: selectedLocation) {
                        do {
                            main.currentWeather = try await fetcher.getCurrentWeather(for: city)
                            main.searchString = city.name
                            main.lastErrorMessage = nil
                        } catch {
                            main.lastErrorMessage = error.localizedDescription
                        }
                    }
                }
        }
    }
    
    private func setSelectedCity(_ location: Location?) {
        if let loc = location {
            do {
                selectedLocation = try JSONEncoder().encode(loc)
            } catch {
                selectedLocation = Data()
                print("Problem encoding location \(loc.name): \(error.localizedDescription)")
            }
        } else {
            selectedLocation = Data()
        }
    }
    
    private func refreshLocations() async {
        do {
            try await fetcher.getLocations(for: main.searchString)
            main.lastErrorMessage = nil
        } catch {
            main.availableLocations = []
            main.lastErrorMessage = error.localizedDescription
        }
    }
}
