//
//  MeteorsRepository.swift
//  Meteors
//
//  Created by Ulaş Sancak on 1.10.2021.
//

import Foundation
import API

typealias MeteorsCompletion = (Result<[Meteor], Error>) -> ()

protocol MeteorsRepository {
    
    func getMeteros(completion: @escaping MeteorsCompletion)
    
}

class MeteorsRemoteRepository: MeteorsRepository {
    
    func getMeteros(completion: @escaping MeteorsCompletion) {
        let api = MeteorAPI()
        api.start { response in
            if response.success {
                completion(.success(response.responseModel ?? []))
            } else {
                completion(.failure(response.error ?? NSError(domain: "", code: 0, userInfo: nil)))
            }
        }
    }
    
}
