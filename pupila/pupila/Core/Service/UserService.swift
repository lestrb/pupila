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
    func fetchUser (by id: CKRecord.ID) async throws -> User?
    func updateUser (_ user: User) async throws -> User
    func deleteUser (by id: CKRecord.ID) async throws
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
        return try await manager.save(user, on: database) // Usa func save do manager
    }

    func fetchUser(by id: CKRecord.ID) async throws -> User? {
        return try await manager.search(for: id, on: database)
    }
    
    func updateUser(_ user: User) async throws -> User {
        // falta implementar
    }
    
    func deleteUser(by id: CKRecord.ID) async throws {
        // falta implementar
    }
}
