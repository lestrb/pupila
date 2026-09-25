//
//  CloudKitManager.swift
//  pupila
//
//  Created by João Fernando Gama Barros on 24/09/26.
//

import Foundation
import CloudKit

class CloudKitManager {
    //nessa classe a gente coloca as funções principais
    static let shared = CloudKitManager() //singleton!!! estamos criando um unico ponto de acesso
    
    let publicDB = CKContainer.default().publicCloudDatabase
    let privateDB = CKContainer.default().privateCloudDatabase //nao vamos usar shared!
    
    private init() {} //aqui a gente forca o construtor do container a pertencer somente ao CloudKitManager
    
    func save <T: CloudKitProtocol> (_ item: T, on database: CKDatabase) async throws -> T {
        _ = try await database.save(item.toRecord())
        
        return item
    }
    
    func search<T: CloudKitProtocol> (for id: CKRecord.ID, on database: CKDatabase) async throws -> T? {
        do {
            let record = try await database.record(for: id)
            return T(record: record)
            
        } catch let error as CKError where error.code == .unknownItem {
            return nil //caso ele nao encontre o objeto no db ele vai retornar vazio
            
        } catch {
            throw error //se der alguma qualquer outra bronca hihihihihi
        }
    }
    
    func delete(for id: CKRecord.ID, on database: CKDatabase) async throws {
        _ = try await database.deleteRecord(withID: id)
    }
}
