//
//  UserService.swift
//  pupila
//
//  Created by Letícia Staudinger Ribeiro on 25/09/26.
//

import Foundation
import CloudKit

protocol UserServiceProtocol {
    func createUser (_ user: User) async throws -> User
}

class UserService: UserServiceProtocol{
    // Dependências
    private let manager: CloudKitManager
    private let database: CKDatabase
    
    // Construtor
    init (manager: CloudKitManager = .shared){ // .shared como padrão
        self.manager = manager
        self.database = manager.publicDB // Dados de user é público, ficarão no perfil
    }
    
    func createUser(_ user: User) async throws -> User {
        return try await manager.save(user, no: database) // Usa func save do manager
    }

    
    
    
    
}
