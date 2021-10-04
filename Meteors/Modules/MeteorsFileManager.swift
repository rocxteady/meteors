//
//  MeteorsFileManager.swift
//  Meteors
//
//  Created by Ulaş Sancak on 2.10.2021.
//

import Foundation

struct MeteorsFileManager {
    
    static let sharedManager = MeteorsFileManager()
    
    private let documentsURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
}

extension MeteorsFileManager {
    
    func getFileData(fileName: String) throws -> Data {
        let url = documentsURL.appendingPathComponent("/" + fileName)
        return try Data(contentsOf: url)
    }
    
    func save(data: Data, fileName: String) throws {
        let url = documentsURL.appendingPathComponent("/" + fileName)
        try data.write(to: url)
    }
    
}
