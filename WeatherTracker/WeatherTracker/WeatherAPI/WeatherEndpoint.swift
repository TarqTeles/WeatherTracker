//
//  WeatherEndpoint.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import Foundation

public final class WeatherEndpoint {
    internal static let baseURLString = "https://api.weatherapi.com/v1"
    internal static let baseURL = URL(string: baseURLString)!
    internal static let apiKey = "5665f5bc10864d60a2a153323242211"
    internal static let searchLocations = "search.json"
    internal static let currentWeather = "current.json"
    
    public static func locations(for loc: String) -> URL {
        let query: [URLQueryItem] = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: loc)
        ]
        return baseURL.appending(path: searchLocations).appending(queryItems: query)
    }
    
    public static func currentWeather(for loc: String) -> URL {
        let query: [URLQueryItem] = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: loc),
            URLQueryItem(name: "aqi", value: "no")
        ]
        return baseURL.appending(path: currentWeather).appending(queryItems: query)
    }
    
    public static func currentWeather(for id: Int) -> URL {
        let query: [URLQueryItem] = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: "id:\(id)"),
            URLQueryItem(name: "aqi", value: "no")
        ]
        return baseURL.appending(path: currentWeather).appending(queryItems: query)
    }
}
