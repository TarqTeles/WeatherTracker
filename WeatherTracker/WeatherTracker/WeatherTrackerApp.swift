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
    
    @AppStorage("selectedCity") var selectedCityName: String = ""

    init() {
        client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        main = MainViewModel()
        fetcher = WeatherFetcher(client: client, viewModel: main)
        
        main.setSelectedCity = setSelectedCity(_:)
        main.getLocationsFor = refreshLocations(for: )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(main: main)
                .task {
                    if selectedCityName != "" {
                        main.searchString = selectedCityName
                        main.currentWeather = try? await fetcher.getCurrentWeather(for: selectedCityName)
                    }
                }
        }
    }
    
    private func setSelectedCity(_ name: String) {
        selectedCityName = name
    }
    
    private func refreshLocations(for str: String) async {
        try? await fetcher.getLocations(for: str)
    }
}
