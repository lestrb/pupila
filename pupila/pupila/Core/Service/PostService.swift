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
}
