//
//  WeatherTrackerTests.swift
//  WeatherTrackerTests
//
//  Created by Tarquinio Teles on 22/11/24.
//

import Testing
import WeatherTracker

struct WeatherTrackerTests {

    @Test func weatherEndpoint_searchLocationReturnsExpectedURL() {
        let partialCityName = "Lond"
        let expectedURL = "http://api.weatherapi.com/v1/search.json?key=5665f5bc10864d60a2a153323242211&q=" + partialCityName
        
        let testURL = WeatherEndpoint.locations(for: partialCityName)
        
        #expect(testURL.absoluteString == expectedURL)
    }

    @Test func weatherEndpoint_currentWeatherReturnsExpectedURL() {
        let cityName = "London"
        let expectedURL = "http://api.weatherapi.com/v1/current.json?key=5665f5bc10864d60a2a153323242211&q=\(cityName)&aqi=no"
        
        let testURL = WeatherEndpoint.currentWeather(for: cityName)
        
        #expect(testURL.absoluteString == expectedURL)
    }
    
}
