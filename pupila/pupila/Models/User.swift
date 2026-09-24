//
//  User.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 14/09/26.
//

import Foundation
import CloudKit

struct User: Identifiable, CloudKitProtocol {
    // Retornados pela Apple com o login
    let id: String // AppleID do usuário (userIdentifier)
    var name: String
    var email: String
    
    // Escolhidos pelo usuário
    var userName: String
    var userPic: URL?
    var userBio: String
    var userLinks: [String]
    
    // Chaves pra mapear no CloudKit
    enum RecordKeys {
        static let recordType = "User"
        static let id = "appleID"
        static let name = "name"
        static let email = "email"
        static let userName = "userName"
        static let userPic = "userPic"
        static let userBio = "userBio"
        static let userLinks = "userLinks"
    }
    
    // Cria o usuário na memória do app
    init(id: String, name: String, email: String, userName: String = "", userPic: URL? = nil, userBio: String = "", userLinks: [String] = []) {
        self.id = id
        self.name = name
        self.email = email
        self.userName = userName
        self.userPic = userPic
        self.userBio = userBio
        self.userLinks = userLinks
    }
    
    // Decodificador de CloudKit pra Swift
    init?(record: CKRecord) {
        // Garante que os dados obrigatórios da Apple existem
        guard let id = record[RecordKeys.id] as? String,
                let name = record[RecordKeys.name] as? String,
                let email = record[RecordKeys.email] as? String else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.email = email
        
        // Dados do usuário
        self.userName = record[RecordKeys.userName] as? String ?? ""
        self.userBio = record[RecordKeys.userBio] as? String ?? ""
        self.userLinks = record[RecordKeys.userLinks] as? [String] ?? []
        
        if let asset = record[RecordKeys.userPic] as? CKAsset {
            self.userPic = asset.fileURL // CKAsset já guarda um fileURL
        } else {
            self.userPic = nil
        }
    }
    
    // Codificador de Swift pra CloudKit
    func toRecord() -> CKRecord {
        let recordID = CKRecord.ID(recordName: id)
        let record = CKRecord(recordType: RecordKeys.recordType, recordID: recordID)
        
        record[RecordKeys.id] = id as CKRecordValue
        record[RecordKeys.name] = name as CKRecordValue
        record[RecordKeys.email] = email as CKRecordValue
        
        record[RecordKeys.userName] = userName as CKRecordValue
        record[RecordKeys.userBio] = userBio as CKRecordValue
        record[RecordKeys.userLinks] = userLinks as CKRecordValue
        
        // Se houver uma URL, transformamos ela num arquivo físico (CKAsset) para enviar pra nuvem
        if let picURL = userPic {
            let asset = CKAsset(fileURL: picURL)
            record[RecordKeys.userPic] = asset
        }
        
        return record
    }
}
