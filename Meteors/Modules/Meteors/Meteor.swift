//
//  Meteor.swift
//  Meteors
//
//  Created by Ulaş Sancak on 30.09.2021.
//

import Foundation

struct Meteor: Codable {
    
    let id: String
    
    let name: String
    
    let geoLocation: GeoLocation
    
    private let year: String

    private let mass: String
    
    let date: String
    
    let timeInterval: TimeInterval
    
    let massFormatted: String
    
    let massDouble: Double
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case year
        case mass
        case geoLocation = "geolocation"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        year = try values.decode(String.self, forKey: .year)
        mass = try values.decode(String.self, forKey: .mass)
        geoLocation = try values.decode(GeoLocation.self, forKey: .geoLocation)
        massDouble = Double(mass) ?? 0
        massFormatted = mass  + " kg"
        var dateFormatter = AppProperties.dateFormatter
        let date = dateFormatter.date(from: year)
        self.timeInterval = date?.timeIntervalSince1970 ?? 0
        dateFormatter = AppProperties.mediumDateFormatter
        self.date = dateFormatter.string(from: date ?? Date())
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(year, forKey: .year)
        try container.encode(mass, forKey: .mass)
        try container.encode(geoLocation, forKey: .geoLocation)
    }
}

extension Meteor: Equatable {
    static func == (lhs: Meteor, rhs: Meteor) -> Bool {
        return lhs.id == rhs.id
    }
}

struct GeoLocation: Codable {
    
    let latitude: Double
    
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case coordinates
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let coordinates = try values.decode([Double].self, forKey: .coordinates)
        guard coordinates.count == 2 else {
            longitude = 0
            latitude = 0
            return
        }
        longitude = coordinates[0]
        latitude = coordinates[1]
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode([longitude, latitude], forKey: .coordinates)
    }
}
