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
    
    init(manager: CloudKitManager = .shared) {
        self.manager = manager
    }
    
    func createPost(_ post: Post) async throws -> Post {
        let savedPost = try await manager.save(post, on: manager.publicDB)
        
        return savedPost
    }
    
    func searchPosts(forUser userID: CKRecord.ID) async throws -> [Post] {
        let userRef = CKRecord.Reference(recordID: userID, action: .none)
        let predicate = NSPredicate(format: "%K == %@", Post.RecordKey.postUserID, userRef) //filtrando com predicado pra retornar um objeto da nuvem a partir do id do usuario
        
        let query = CKQuery(recordType: Post.RecordKey.recordType, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: Post.RecordKey.postDate, ascending: false)] //ordenando pela data do maior pro menor
        
        let records: [Post] = try await manager.search(with: query, on: manager.publicDB) //tem que ser explicitamente do [Post] pra dar certo
        
        return records
    }
    
    func searchPosts(forGallery galleryID: CKRecord.ID) async throws -> [Post] {
        let galleryRef = CKRecord.Reference(recordID: galleryID, action: .none)
        let predicate = NSPredicate(format: "%K == %@", Post.RecordKey.postGalleryID, galleryRef)
        
        let query = CKQuery(recordType: Post.RecordKey.recordType, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: Post.RecordKey.postDate, ascending: false)]
        
        let records: [Post] = try await manager.search(with: query, on: manager.publicDB)
        
        return records
    }
}
