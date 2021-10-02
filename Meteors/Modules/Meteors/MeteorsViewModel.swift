//
//  MeteorsViewModel.swift
//  Meteors
//
//  Created by Ulaş Sancak on 30.09.2021.
//

import Foundation

class MeteorsViewModel {
    
    private var repository: MeteorsRepository
    
    private var currentOrder: SegmentedControlType = .date
    
    var isEditable: Bool {
        return repository.isEditable
    }
        
    var meteorsReady: () -> () = {}
    
    var errorReceived: (_ error: Error) -> () = { _ in }
    
    var numberOfMeteros: Int {
        repository.meteors.count
    }
    
    func meteor(at index: Int) -> Meteor {
        repository.meteors[index]
    }
    
    init(repository: MeteorsRepository) {
        self.repository = repository
    }
    
}

extension MeteorsViewModel {
    
    func getMeteors(order: SegmentedControlType? = .date, shouldRefresh: Bool = true) {
        guard shouldRefresh else {
            if let order = order, currentOrder != order {
                orderBy(order)
            } else {
                meteorsReady()
            }
            return
        }
        repository.getMeteros { [weak self] error in
            if let error = error {
                self?.errorReceived(error)
            } else if let order = order {
                self?.orderBy(order)
            } else {
                self?.meteorsReady()
            }
        }
    }
    
    func removeMeteor(at index: Int) {
        repository.removeFromFavorite(meteor: repository.meteors[index]) { [weak self] error in
            if let error = error {
                self?.errorReceived(error)
            }
        }
    }
    
    func add(meteor: Meteor) {
        repository.addToFavorite(meteor: meteor) { [weak self] error in
            if let error = error {
                self?.errorReceived(error)
            }
        }
    }
    
    private func orderBy(_ orderType: SegmentedControlType) {
        switch orderType {
        case .date:
            repository.meteors.sort { lhs, rhs in
                return lhs.timeInterval > rhs.timeInterval
            }
        case .size:
            repository.meteors.sort { lhs, rhs in
                return lhs.massDouble > rhs.massDouble
            }
        }
        currentOrder = orderType
        meteorsReady()
    }
    
    
}
