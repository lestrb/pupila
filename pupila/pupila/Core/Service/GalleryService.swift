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
    func searchGalleries(isOpen bool: Bool) async throws -> [Gallery]
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
    
    func searchGalleries(isOpen bool: Bool) async throws -> [Gallery] {
        //retorna as galeras segundo o filtro
        let predicate = NSPredicate(format: "%K == %d", Gallery.RecordKey.isOpen, bool) //eu acho que funciona!! gege, me ajuda!
        
        let query = CKQuery(recordType: Gallery.RecordKey.recordType, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: Gallery.RecordKey.galleryDeadline, ascending: false)]
        
        let records: [Gallery] = try await manager.search(with: query, on: database)
        
        return records //ownn. companheiras e companheiros
    }
    
    func deleteGallery(_ id: CKRecord.ID) async throws {
        try await manager.delete(for: id, on: database)
    }
}
