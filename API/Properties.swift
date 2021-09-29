//
//  Properties.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

public struct Properties {
    public static let baseURL = "https://data.nasa.gov/resource"
    public static let apiKey = "S4aQuLPdtNJo5dcXAwSHlGxXY"
    public static let headers: [String: String] = ["X-App-Token":Properties.apiKey]
}
