//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import SwiftUI

@Observable class WeatherViewModel {
    let model: CurrentWeather
    var locationName: String { model.location.name }
    var temperatureCelsius: String { String(Int(model.current.tempC)) }
    let icon: Image

    init(currentWeather: CurrentWeather, icon: Image) {
        self.model = currentWeather
        self.icon = icon
    }
}
