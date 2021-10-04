//
//  BaseRequestModel.swift
//  API
//
//  Created by Ulaş Sancak on 10.11.2020.
//

import Foundation

open class BaseRequestModel: Encodable {
        
    var `where` = "year>'1900' AND mass>0 AND geolocation IS NOT NULL"
    
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case `where` = "$where"
    }
}
