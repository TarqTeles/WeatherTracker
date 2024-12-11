//
//  MainViewModel.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import SwiftUI

@MainActor
@Observable public class MainViewModel {
    var currentWeather: WeatherViewModel?
    var availableLocations: [WeatherViewModel]
    var searchString: String = ""
    var lastErrorMessage: String?
    
    var getLocationsFor: (() async -> Void)?
    var setSelectedCity: ((Location?) -> Void)?
    
    init(currentWeather: WeatherViewModel? = nil, availableLocations: [WeatherViewModel] = []) {
        self.currentWeather = currentWeather
        self.availableLocations = availableLocations
    }
}
