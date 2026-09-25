//
//  Post.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 14/09/26.
//
//eh minha primeira vez usando CloudKit. Vou me dar a liberdade de comentar mais o codigo

import Foundation
import CloudKit

struct Post: Identifiable, CloudKitProtocol, Hashable {
    enum RecordKey{ //variaveis que o bd vai ter acesso (mapeando e tal)
        static let recordType = "Post" //isso aqui eh o nome da tabela no bd
        static let postUserID = "postUserID"
        static let postGalleryID = "postGalleryID"
        static let postDescription = "postDescription"
        static let postDate = "postDate"
        static let isPublic =  "isPublic"
        static let postPhoto = "postPhoto"
    }
    
    let id: CKRecord.ID
    var postUserID: CKRecord.Reference //uma referencia!! tipo o @relationship do Swift Data!
    var postGalleryID: CKRecord.Reference //vamos usar o postUserID e o postGalleryID como referencia pro relacionamento entre user e gallery
    var postDescription: String?
    var postDate: Date
    var isPublic: Bool
    var postPhotoURL: URL? //URL da imagem salva em disco que vamos passar como CKAsset 😎
        
    init( //inicializando o post com valores padrao
        id: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString),
        postUserID: CKRecord.Reference,
        postGalleryID: CKRecord.Reference,
        postDescription: String? = nil, //a descricao eh opcional mesmo?sim
        postDate: Date = Date(),
        isPublic: Bool = true, //todo post publicado inicialmente eh publico ok? ok.
        postPhotoURL: URL? = nil
    ) { //ainda é preciso inicializar a struct com o init padrao (para alem do init?)
        self.id = id
        self.postUserID = postUserID
        self.postGalleryID = postGalleryID
        self.postDescription = postDescription
        self.postDate = postDate
        self.isPublic = isPublic
        self.postPhotoURL = postPhotoURL
    }
    
    init?(record: CKRecord) { //lendo da nuvem
        guard let postUserID = record[RecordKey.postUserID] as? CKRecord.Reference,
              let postGalleryID = record[RecordKey.postGalleryID] as? CKRecord.Reference, //o CKRecord funciona como um dicionario!! to atribuindo a string "postDescription"
              let postDate = record[RecordKey.postDate] as? Date,
              let isPublic = record[RecordKey.isPublic] as? Bool else {
            return nil
        }
        
        self.id = record.recordID
        self.postUserID = postUserID
        self.postGalleryID = postGalleryID
        self.postDate = postDate
        self.isPublic = isPublic
        
        self.postDescription = record[RecordKey.postDescription] as? String
        //eventualmente vai ter a logica pra baixar da nuvem e salvar no disco do iphone
        if let asset = record[RecordKey.postPhoto] as? CKAsset {
            self.postPhotoURL = asset.fileURL
        } else {
            self.postPhotoURL = nil
        }
    }
    
    func toRecord() -> CKRecord { //converte o modelo struct para CKRecord (aka salvando na nuvem)
        let record = CKRecord(recordType: RecordKey.recordType, recordID: id)
        record[RecordKey.postUserID] = postUserID
        record[RecordKey.postGalleryID] = postGalleryID
        record[RecordKey.postDate] = postDate as CKRecordValue //transformando no tipo legivel pelo bd
        record[RecordKey.isPublic] = isPublic as CKRecordValue
        
        if let postDescription = postDescription {
            record[RecordKey.postDescription] = postDescription as CKRecordValue
        }
        
        if let photoURL = postPhotoURL { //desempacotando photoURL
            let asset = CKAsset(fileURL: photoURL)
            record[RecordKey.postPhoto] = asset
        }
        
        return record
    }
}
