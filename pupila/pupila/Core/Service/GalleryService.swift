//
//  GalleryService.swift
//  pupila
//
//  Created by João Fernando Gama Barros on 28/09/26.
//

import Foundation
import CloudKit

protocol GalleryServiceProtocol {
    func createGallery(_ gallery: Gallery) async throws -> Gallery
    func deleteGallery(_ id: CKRecord.ID) async throws
}

class GalleryService: GalleryServiceProtocol {
    private let manager: CloudKitManager
    private let database: CKDatabase
    
    init(manager: CloudKitManager = .shared) {
        self.manager = manager
        self.database = manager.publicDB
    }
    
    func createGallery(_ gallery: Gallery) async throws -> Gallery {
        let savedGallery = try await manager.save(gallery, on: database)
        
        return savedGallery
    }
    
    func deleteGallery(_ id: CKRecord.ID) async throws {
        try await manager.delete(for: id, on: database)
    }
}
