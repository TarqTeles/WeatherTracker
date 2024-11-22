//
//  MainViewModel.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import SwiftUI

@Observable class MainViewModel {
    var currentWeather: CurrentWeather?
    var availableLocations: [CurrentWeather]
    var seachString: String = ""
    
    init(currentWeather: CurrentWeather? = nil, availableLocations: [CurrentWeather] = []) {
        self.currentWeather = currentWeather
        self.availableLocations = availableLocations
    }
}
