//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import SwiftUI

@Observable public final class WeatherViewModel: Identifiable, Sendable {
    private let model: CurrentWeather
    public let id = UUID()
    public var locationName: String { "\(model.location.name)" }
    public var temperatureCelsius: String { String(Int(model.current.tempC)) + "º" }
    public var humidity: String { String(Int(model.current.humidity)) + "%" }
    public var UV: String { String(Int(model.current.uv)) }
    public var feelsLike: String { String(Int(model.current.feelslikeC)) + "º" }
    public let icon: Image

    init(currentWeather: CurrentWeather, icon: Image) {
        self.model = currentWeather
        self.icon = icon
    }
}
