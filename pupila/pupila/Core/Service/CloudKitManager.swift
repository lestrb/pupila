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
}
