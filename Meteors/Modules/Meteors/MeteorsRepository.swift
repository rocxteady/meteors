//
//  MeteorsRepository.swift
//  Meteors
//
//  Created by Ulaş Sancak on 1.10.2021.
//

import Foundation
import API

typealias MeteorsCompletion = (_ error: Error?) -> ()

protocol MeteorsRepository {
    
    var meteors: [Meteor] { get set }
    var isEditable: Bool { get }
    func getMeteros(completion: @escaping MeteorsCompletion)
    func addToFavorite(meteor: Meteor, completion: @escaping MeteorsCompletion)
    func removeFromFavorite(meteor: Meteor, completion: @escaping MeteorsCompletion)
    
}

extension MeteorsRepository {
    func addToFavorite(meteor: Meteor, completion: @escaping MeteorsCompletion) {}
    func removeFromFavorite(meteor: Meteor, completion: @escaping MeteorsCompletion) {}
}

class MeteorsRemoteRepository: MeteorsRepository {
    
    var meteors: [Meteor] = []
    
    let isEditable: Bool = false
    
    func getMeteros(completion: @escaping MeteorsCompletion) {
        let api = MeteorAPI()
        api.start { response in
            if response.success {
                self.meteors = response.responseModel ?? []
                completion(nil)
            } else if let error = response.error {
                completion(error)
            } else {
                completion(NSError(domain: "", code: 0, userInfo: nil))
            }
        }
    }
    
}

class MeteorsLocalRepository: MeteorsRepository {
    
    var meteors: [Meteor] = []
    
    let isEditable: Bool = true
    
    private let fileName = "meteors.json"
    
    func getMeteros(completion: @escaping MeteorsCompletion) {
        DispatchQueue.global().async { [weak self] in
            do {
                let data = try MeteorsFileManager.sharedManager.getFileData(fileName: self?.fileName ?? "")
                let meteors: [Meteor] = try data.toDecodable()
                DispatchQueue.main.async {
                    self?.meteors = meteors
                    completion(nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }
    }
    
    func addToFavorite(meteor: Meteor, completion: @escaping MeteorsCompletion) {
        guard !meteors.contains(meteor) else {
            completion(nil)
            return
        }
        meteors.append(meteor)
        save(completion: completion)
    }
    
    func removeFromFavorite(meteor: Meteor, completion: @escaping MeteorsCompletion) {
        guard let index = meteors.firstIndex(of: meteor) else {
            completion(nil)
            return
        }
        meteors.remove(at: index)
        save(completion: completion)
    }
    
    private func save(completion: @escaping MeteorsCompletion) {
        do {
            let data = try meteors.toData()
            try MeteorsFileManager.sharedManager.save(data: data, fileName: fileName)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
}
