//
//  CurrentWeather.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//
// This file was generated from JSON Schema using quicktype, using Offline Dev Toolkit

import Foundation

public struct CurrentWeather: Codable {
    let location: WeatherLocation
    let current: Current
}

// MARK: Welcome convenience initializers and mutators

extension CurrentWeather {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CurrentWeather.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        location: WeatherLocation? = nil,
        current: Current? = nil
    ) -> CurrentWeather {
        return CurrentWeather(
            location: location ?? self.location,
            current: current ?? self.current
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.currentTask(with: url) { current, response, error in
//     if let current = current {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Current
public struct Current: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph, windKph: Double
    let windDegree: Double
    let windDir: String
    let pressureMB: Double
    let pressureIn: Double
    let precipMm, precipIn, humidity, cloud: Double
    let feelslikeC, feelslikeF, windchillC, windchillF: Double
    let heatindexC, heatindexF, dewpointC, dewpointF: Double
    let visKM, visMiles, uv: Double
    let gustMph, gustKph: Double
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

// MARK: Current convenience initializers and mutators

extension Current {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Current.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        lastUpdatedEpoch: Int? = nil,
        lastUpdated: String? = nil,
        tempC: Double? = nil,
        tempF: Double? = nil,
        isDay: Int? = nil,
        condition: Condition? = nil,
        windMph: Double? = nil,
        windKph: Double? = nil,
        windDegree: Double? = nil,
        windDir: String? = nil,
        pressureMB: Double? = nil,
        pressureIn: Double? = nil,
        precipMm: Double? = nil,
        precipIn: Double? = nil,
        humidity: Double? = nil,
        cloud: Double? = nil,
        feelslikeC: Double? = nil,
        feelslikeF: Double? = nil,
        windchillC: Double? = nil,
        windchillF: Double? = nil,
        heatindexC: Double? = nil,
        heatindexF: Double? = nil,
        dewpointC: Double? = nil,
        dewpointF: Double? = nil,
        visKM: Double? = nil,
        visMiles: Double? = nil,
        uv: Double? = nil,
        gustMph: Double? = nil,
        gustKph: Double? = nil
    ) -> Current {
        return Current(
            lastUpdatedEpoch: lastUpdatedEpoch ?? self.lastUpdatedEpoch,
            lastUpdated: lastUpdated ?? self.lastUpdated,
            tempC: tempC ?? self.tempC,
            tempF: tempF ?? self.tempF,
            isDay: isDay ?? self.isDay,
            condition: condition ?? self.condition,
            windMph: windMph ?? self.windMph,
            windKph: windKph ?? self.windKph,
            windDegree: windDegree ?? self.windDegree,
            windDir: windDir ?? self.windDir,
            pressureMB: pressureMB ?? self.pressureMB,
            pressureIn: pressureIn ?? self.pressureIn,
            precipMm: precipMm ?? self.precipMm,
            precipIn: precipIn ?? self.precipIn,
            humidity: humidity ?? self.humidity,
            cloud: cloud ?? self.cloud,
            feelslikeC: feelslikeC ?? self.feelslikeC,
            feelslikeF: feelslikeF ?? self.feelslikeF,
            windchillC: windchillC ?? self.windchillC,
            windchillF: windchillF ?? self.windchillF,
            heatindexC: heatindexC ?? self.heatindexC,
            heatindexF: heatindexF ?? self.heatindexF,
            dewpointC: dewpointC ?? self.dewpointC,
            dewpointF: dewpointF ?? self.dewpointF,
            visKM: visKM ?? self.visKM,
            visMiles: visMiles ?? self.visMiles,
            uv: uv ?? self.uv,
            gustMph: gustMph ?? self.gustMph,
            gustKph: gustKph ?? self.gustKph
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.conditionTask(with: url) { condition, response, error in
//     if let condition = condition {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Condition
public struct Condition: Codable {
    let text, icon: String
    let code: Int
}

// MARK: Condition convenience initializers and mutators

extension Condition {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Condition.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        text: String? = nil,
        icon: String? = nil,
        code: Int? = nil
    ) -> Condition {
        return Condition(
            text: text ?? self.text,
            icon: icon ?? self.icon,
            code: code ?? self.code
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - WeatherLocation
public struct WeatherLocation: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String
    
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

// MARK: WeatherLocation convenience initializers and mutators

extension WeatherLocation {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(WeatherLocation.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        name: String? = nil,
        region: String? = nil,
        country: String? = nil,
        lat: Double? = nil,
        lon: Double? = nil,
        tzID: String? = nil,
        localtimeEpoch: Int? = nil,
        localtime: String? = nil
    ) -> WeatherLocation {
        return WeatherLocation(
            name: name ?? self.name,
            region: region ?? self.region,
            country: country ?? self.country,
            lat: lat ?? self.lat,
            lon: lon ?? self.lon,
            tzID: tzID ?? self.tzID,
            localtimeEpoch: localtimeEpoch ?? self.localtimeEpoch,
            localtime: localtime ?? self.localtime
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


// MARK: - Helper functions for creating encoders and decoders

private func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

private func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

