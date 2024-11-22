//
//  MainViewModel.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import SwiftUI

@Observable public class MainViewModel {
    var currentWeather: WeatherViewModel?
    var availableLocations: [WeatherViewModel]
    var searchString: String = ""
    
    var getLocationsFor: ((String) async -> Void)?
    var setSelectedCity: ((String) -> Void)?
    
    init(currentWeather: WeatherViewModel? = nil, availableLocations: [WeatherViewModel] = []) {
        self.currentWeather = currentWeather
        self.availableLocations = availableLocations
    }
}
