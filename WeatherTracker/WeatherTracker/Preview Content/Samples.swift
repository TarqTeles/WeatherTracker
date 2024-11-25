//
//  Samples.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 25/11/24.
//

import SwiftUI

public enum Samples {
    public static let londonCalling = "https://api.weatherapi.com/v1/current.json?key=5665f5bc10864d60a2a153323242211&q=London&aqi=no"
    public static let londonJSONReturn = "{\"location\":{\"name\":\"London\",\"region\":\"City of London, Greater London\",\"country\":\"United Kingdom\",\"lat\":51.5171,\"lon\":-0.1062,\"tz_id\":\"Europe/London\",\"localtime_epoch\":1732549602,\"localtime\":\"2024-11-25 15:46\"},\"current\":{\"last_updated_epoch\":1732549500,\"last_updated\":\"2024-11-25 15:45\",\"temp_c\":11.3,\"temp_f\":52.3,\"is_day\":1,\"condition\":{\"text\":\"Partly cloudy\",\"icon\":\"//cdn.weatherapi.com/weather/64x64/day/116.png\",\"code\":1003},\"wind_mph\":13.4,\"wind_kph\":21.6,\"wind_degree\":242,\"wind_dir\":\"WSW\",\"pressure_mb\":1004.0,\"pressure_in\":29.65,\"precip_mm\":0.0,\"precip_in\":0.0,\"humidity\":58,\"cloud\":25,\"feelslike_c\":8.9,\"feelslike_f\":48.0,\"windchill_c\":7.6,\"windchill_f\":45.8,\"heatindex_c\":10.3,\"heatindex_f\":50.6,\"dewpoint_c\":3.8,\"dewpoint_f\":38.8,\"vis_km\":10.0,\"vis_miles\":6.0,\"uv\":0.2,\"gust_mph\":18.9,\"gust_kph\":30.4}}"
    public static let londonRerurn_tempC = 11.3
    public static let londonRerurn_hum = 58
    public static let londonRerurn_uv = 0.2
    public static let londonRerurn_feelsLike = 8.9
    
    public static let londonReturnData = londonJSONReturn.data(using: .utf8)!
    public static let londonReturnModel = try! CurrentWeather(data: londonReturnData)
    
    public static let missingIconImage = Image(systemName: "photo")

}
