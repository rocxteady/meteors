//
//  MeteorsViewModel.swift
//  Meteors
//
//  Created by Ulaş Sancak on 30.09.2021.
//

import Foundation

class MeteorsViewModel {
    
    var meteors: [Meteor]?
    
    var numberOfMeteros: Int {
        meteors?.count ?? 0
    }
}
