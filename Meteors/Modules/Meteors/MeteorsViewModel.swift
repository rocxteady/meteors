//
//  MeteorsViewModel.swift
//  Meteors
//
//  Created by Ulaş Sancak on 30.09.2021.
//

import Foundation

class MeteorsViewModel {
    
    private let repository: MeteorsRepository
    
    private var currentOrder: SegmentedControlType = .date
    
    var meteors: [Meteor] = []
    
    var meteorsReady: () -> () = {}
    
    var errorReceived: (_ error: Error) -> () = { _ in }
    
    var numberOfMeteros: Int {
        meteors.count
    }
    
    func meteor(at index: Int) -> Meteor {
        meteors[index]
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
        repository.getMeteros { [weak self] result in
            switch result {
                case .success(let meteors):
                self?.meteors = meteors
                if let order = order {
                    self?.orderBy(order)
                } else {
                    self?.meteorsReady()
                }
            case .failure(let error):
                self?.errorReceived(error)
            }
        }
    }
    
    private func orderBy(_ orderType: SegmentedControlType) {
        switch orderType {
        case .date:
            meteors.sort { lhs, rhs in
                return lhs.timeInterval > rhs.timeInterval
            }
        case .size:
            meteors.sort { lhs, rhs in
                return lhs.massDouble > rhs.massDouble
            }
        }
        currentOrder = orderType
        meteorsReady()
    }
    
    
}
