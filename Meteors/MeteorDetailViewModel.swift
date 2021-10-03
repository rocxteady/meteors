//
//  MeteorDetailViewModel.swift
//  Meteors
//
//  Created by Ulaş Sancak on 3.10.2021.
//

import Foundation

class MeteorDetailViewModel {
    
    private let repository: MeteorsRepository

    private let meteor: Meteor
    
    var isFavorited: Bool {
        return repository.meteors.contains(meteor)
    }
    
    var updatedFavoriteStatus: () -> () = {}
    var errorReceived: (_ error: Error) -> () = { _ in }
    
    init(repository: MeteorsRepository, meteor: Meteor) {
        self.repository = repository
        self.meteor = meteor
    }
    
}

extension MeteorDetailViewModel {
    
    func getMeteors() {
        repository.getMeteros { [weak self] error in
            if let error = error {
                self?.errorReceived(error)
            } else {
                self?.updatedFavoriteStatus()
            }
        }
    }
    
    func removeFromFavorites() {
        repository.removeFromFavorite(meteor: meteor) { [weak self] error in
            if let error = error {
                self?.errorReceived(error)
            }
            self?.updatedFavoriteStatus()
        }
    }
    
    func addToFavorites() {
        repository.addToFavorite(meteor: meteor) { [weak self] error in
            if let error = error {
                self?.errorReceived(error)
            }
            self?.updatedFavoriteStatus()
        }
    }
    
}
