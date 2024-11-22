//
//  WeatherTrackerApp.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import SwiftUI

@main
struct WeatherTrackerApp: App {
    let fetcher = WeatherFetcher()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    try? await fetcher.getCurrentWeather(for: "London")
                    _ = print(fetcher.currentWeather?.tempC)
                }
        }
    }
}
