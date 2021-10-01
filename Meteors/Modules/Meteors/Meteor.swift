//
//  Meteor.swift
//  Meteors
//
//  Created by Ulaş Sancak on 30.09.2021.
//

import Foundation

struct Meteor: Decodable {
    
    let name: String
    
    let date: String
    
    let timeInterval: TimeInterval
    
    let mass: String
    
    let massDouble: Double
    
    private let year: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case year
        case mass
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        year = try values.decode(String.self, forKey: .year)
        let mass = try values.decode(String.self, forKey: .mass)
        massDouble = Double(mass) ?? 0
        self.mass = mass  + " kg"
        var dateFormatter = AppProperties.dateFormatter
        let date = dateFormatter.date(from: year)
        self.timeInterval = date?.timeIntervalSince1970 ?? 0
        dateFormatter = AppProperties.mediumDateFormatter
        self.date = dateFormatter.string(from: date ?? Date())
    }
}
