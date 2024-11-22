//
//  Location.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

// This file was generated from JSON Schema using quicktype on Offline Dev Toolkit.

import Foundation

public struct Location: Codable {
    let id: Int
    let name, region, country: String
    let lat, lon: Double
    let url: String
}

extension Location {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Location.self, from: data)
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
        id: Int? = nil,
        name: String? = nil,
        region: String? = nil,
        country: String? = nil,
        lat: Double? = nil,
        lon: Double? = nil,
        url: String? = nil
    ) -> Location {
        return Location(
            id: id ?? self.id,
            name: name ?? self.name,
            region: region ?? self.region,
            country: country ?? self.country,
            lat: lat ?? self.lat,
            lon: lon ?? self.lon,
            url: url ?? self.url
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias Locations = [Location]

extension Array where Element == Locations.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Locations.self, from: data)
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
