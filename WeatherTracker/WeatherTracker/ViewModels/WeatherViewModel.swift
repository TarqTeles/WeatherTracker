//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import SwiftUI

@Observable public class WeatherViewModel: Identifiable {
    private let model: CurrentWeather
    public let id = UUID()
    public var locationName: String { "\(model.location.name)" }
    public var temperatureCelsius: String { String(Int(model.current.tempC)) }
    public let icon: Image

    init(currentWeather: CurrentWeather, icon: Image) {
        self.model = currentWeather
        self.icon = icon
    }
}
