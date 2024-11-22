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

    init() {
        client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        main = MainViewModel()
        fetcher = WeatherFetcher(client: client, viewModel: main)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(main: main)
                .task {
                    try? await fetcher.getLocations(for: "Lond")
                }
        }
    }
}
