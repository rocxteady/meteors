//
//  MeteorsRequestModel.swift
//  Meteors
//
//  Created by Ulaş Sancak on 1.10.2021.
//

import Foundation
import API

enum MeteorOrder: String, Encodable {
    case date = "year DESC"
    case size = "mass DESC"
}

class MeteorsRequestModel: BaseRequestModel {
    
    let order: MeteorOrder
    
    init(order: MeteorOrder = .date) {
        self.order = order
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case order = "$order"
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order, forKey: .order)
    }
}
