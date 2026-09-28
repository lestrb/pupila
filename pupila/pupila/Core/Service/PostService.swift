//
//  PostService.swift
//  pupila
//
//  Created by João Fernando Gama Barros on 25/09/26.
//

import Foundation
import CloudKit

protocol PostServiceProtocol { //forcando o post service a seguir esses formatos de funcao
    func createPost(_ post: Post) async throws -> Post
    func searchPosts(forUser UserID: CKRecord.ID) async throws -> [Post]
    func searchPosts(forGallery galleryID: CKRecord.ID) async throws -> [Post]
    
}

class PostService: PostServiceProtocol {
    private let manager: CloudKitManager
    private let database: CKDatabase
    
    init(manager: CloudKitManager = .shared) {
        self.manager = manager
        self.database = manager.publicDB //boas praticas coisa e tal e tal e coisa e pa e bra
    }
    
    func createPost(_ post: Post) async throws -> Post {
        let savedPost = try await manager.save(post, on: database)
        
        return savedPost
    }
    
    func searchPosts(forUser userID: CKRecord.ID) async throws -> [Post] {
        let userRef = CKRecord.Reference(recordID: userID, action: .none)
        let predicate = NSPredicate(format: "%K == %@", Post.RecordKey.postUserID, userRef) //filtrando com predicado pra retornar um objeto da nuvem a partir do id do usuario
        
        let query = CKQuery(recordType: Post.RecordKey.recordType, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: Post.RecordKey.postDate, ascending: false)] //ordenando pela data do maior pro menor
        
        let records: [Post] = try await manager.search(with: query, on: database) //tem que ser explicitamente do [Post] pra dar certo
        
        return records
    }
    
    func searchPosts(forGallery galleryID: CKRecord.ID) async throws -> [Post] {
        let galleryRef = CKRecord.Reference(recordID: galleryID, action: .none)
        let predicate = NSPredicate(format: "%K == %@", Post.RecordKey.postGalleryID, galleryRef)
        
        let query = CKQuery(recordType: Post.RecordKey.recordType, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: Post.RecordKey.postDate, ascending: false)]
        
        let records: [Post] = try await manager.search(with: query, on: database)
        
        return records
    }
    
    func deletePost(_ id: CKRecord.ID) async throws {
        try await manager.delete(for: id, on: database)
    }
}
