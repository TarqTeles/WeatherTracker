//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import SwiftUI

@Observable public final class WeatherViewModel: Identifiable, Sendable {
    private let model: CurrentWeather
    public let city: Location
    public var id: Int { city.id ?? Int.random(in: Int.min..<0) }
    public var locationName: String { "\(city.name)" }
    public var locationRegion: String { "\(city.region)" }
    public var locationRegionAndCountry: String { [city.region, city.country].joined(separator: ", ") }
    public var temperatureCelsius: String { String(Int(model.current.tempC)) + "º" }
    public var humidity: String { String(Int(model.current.humidity)) + "%" }
    public var UV: String { String(Int(model.current.uv)) }
    public var feelsLike: String { String(Int(model.current.feelslikeC)) + "º" }
    public let icon: Image

    init(currentWeather: CurrentWeather, at location: Location, icon: Image) {
        self.model = currentWeather
        self.city = location
        self.icon = icon
    }
}
