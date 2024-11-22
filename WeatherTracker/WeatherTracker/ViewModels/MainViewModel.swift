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
    var seachString: String = ""
    
    init(currentWeather: WeatherViewModel? = nil, availableLocations: [WeatherViewModel] = []) {
        self.currentWeather = currentWeather
        self.availableLocations = availableLocations
    }
}
