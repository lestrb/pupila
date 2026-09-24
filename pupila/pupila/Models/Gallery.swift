//
//  Gallery.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 14/09/26.
//

import Foundation
import CloudKit

struct Gallery: Identifiable, CloudKitProtocol, Hashable {
    
    enum RecordKey {
        static let recordType = "Gallery"
        static let galleryName = "galleryName"
        static let galleryDeadline = "galleryDeadline"
        static let isOpen = "isOpen"
        static let galleryPhotoCounter = "galleryPhotoCounter"
        static let galleryCover = "galleryCover"
    }
    
    var id: CKRecord.ID
    var galleryName: String
    var galleryDeadline: Date
    var galleryCoverURL: URL?
    var isOpen: Bool
    var galleryPhotoCounter: Int64
    //var galleryPosts: [CKRecord.Reference] //um array de referencias aos ids dos posts que pertencem aa gallery -> nao precisa, ja estamos instanciando essas relacoes em post
    
    
    init(
        id: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString),
        galleryName: String,
        galleryDeadline: Date = Date(),
        galleryCoverURL: URL? = nil,
        isOpen: Bool = true,
        galleryPhotoCounter: Int64
        
    ) {
        self.id = id
        self.galleryName = galleryName
        self.galleryDeadline = galleryDeadline
        self.galleryCoverURL = galleryCoverURL
        self.isOpen = isOpen
        self.galleryPhotoCounter = galleryPhotoCounter
    }
    
    init?(record:CKRecord) {
        guard let galleryName = record[RecordKey.galleryName] as? String,
              //let galleryPosts = record["galleryPosts"] as? [CKRecord.Reference], //nao precisa referenciar os filhos do pai ne ahaahhahahah😎
              let galleryDeadline = record[RecordKey.galleryDeadline] as? Date,
              let galleryPhotoCounter = record[RecordKey.galleryPhotoCounter] as? Int64,
              let isOpen = record[RecordKey.isOpen] as? Int64 else {
            return nil
        }
        
        self.id = record.recordID
        self.galleryName = galleryName
        self.galleryDeadline = galleryDeadline
        self.galleryPhotoCounter = galleryPhotoCounter
        self.isOpen = (isOpen == 1)
        
        
        //self.galleryPosts = record["galleryPosts"] as? [CKRecord.Reference] ?? [] //inicializa como array vazio por seguranca caso o guard let retorne nil
        
        if let asset = record["galleryCover"] as? CKAsset {
            self.galleryCoverURL = asset.fileURL
        } else {
            self.galleryCoverURL = nil
        }
    }
    
    func toRecord() -> CKRecord {
        let record = CKRecord(recordType: RecordKey.recordType, recordID: id)
        record[RecordKey.galleryName] = galleryName as CKRecordValue
        record[RecordKey.isOpen] = (isOpen ? 1 : 0) as CKRecordValue
        record[RecordKey.galleryDeadline] = galleryDeadline as CKRecordValue
        record[RecordKey.galleryPhotoCounter] = galleryPhotoCounter as CKRecordValue
        
//        if !galleryPosts.isEmpty { //se nao tiver vazio, da pra inicializar no container normalmente
//            record["galleryPosts"] = galleryPosts as CKRecordValue
//        }
        
        if let coverURL = galleryCoverURL {
            let asset = CKAsset(fileURL: coverURL)
            record["galleryCover"] = asset
        }
        
        return record
        
    }
}
