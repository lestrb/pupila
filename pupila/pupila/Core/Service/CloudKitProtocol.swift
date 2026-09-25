//
//  CloudKitProtocol.swift
//  pupila
//
//  Created by Letícia Staudinger Ribeiro on 24/09/26.
//

import Foundation
import CloudKit

// Será protocolo para que o CRUD aceite tipos User, Post e Galley que obrigatoriamente seguem esse protocolo
protocol CloudKitProtocol {
    // Criação com tipo CKRecord
    init?(record: CKRecord)
    
    // Transformando em CKRecord
    func toRecord() -> CKRecord
}
