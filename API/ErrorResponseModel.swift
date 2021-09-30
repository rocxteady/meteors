//
//  BaseResponseModel.swift
//  API
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import Foundation

class ErrorResponseModel: Decodable {
    
    let error: Bool
    let message: String
    
}
