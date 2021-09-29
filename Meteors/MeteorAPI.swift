//
//  MeteorAPI.swift
//  Meteors
//
//  Created by Ulaş Sancak on 30.09.2021.
//

import Foundation
import API
import RestClient

class MeteorAPI: API {
    
    public typealias ResponseModel = [Meteor]

    public typealias RequestModel = BaseRequestModel
        
    public var uri = "/y77d-th95.json"
    
    public var endpoint: RestEndpoint
    
    public var parameters: RequestModel {
        didSet {
            endpoint.parameters = try? parameters.toDictionary()
        }
    }
    
    public init(parameters: RequestModel = RequestModel()) {
        endpoint = RestEndpoint(urlString: Properties.baseURL + uri, parameters: try? parameters.toDictionary())
        self.parameters = parameters
    }
    
}
