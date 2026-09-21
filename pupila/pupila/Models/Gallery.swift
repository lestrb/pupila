//
//  Gallery.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 14/09/26.
//

import Foundation
import SwiftUI
import CloudKit

import SwiftData

struct Gallery {
    var galleryID: CKRecord.ID
    var galleryName: String
    var galleryPosts: [CKRecord.Reference] //um array de referencias aos ids dos posts que pertencem aa gallery
    var isOpen: Bool
    var galleryCoverURL: URL?
    
    static let recordType = "Gallery"
    
    init?(record:CKRecord) {
        guard let galleryName = record["galleryName"] as? String,
              //let galleryPosts = record["galleryPosts"] as? [CKRecord.Reference], //nao precisa referenciar os filhos do pai ne ahaahhahahah😎
              let isOpen = record["isOpen"] as? Int64 else {
            return nil
        }
        
        self.galleryID = record.recordID
        self.galleryName = galleryName
        self.isOpen = (isOpen == 1)
        
        self.galleryPosts = record["galleryPosts"] as? [CKRecord.Reference] ?? [] //inicializa como array vazio por seguranca caso o guard let retorne nil
        
        if let asset = record["galleryCover"] as? CKAsset {
            self.galleryCoverURL = asset.fileURL
        } else {
            self.galleryCoverURL = nil
        }
    }
    
    func toRecord() -> CKRecord {
        let record = CKRecord(recordType: Self.recordType, recordID: galleryID)
        record["galleryName"] = galleryName as CKRecordValue
        record["isOpen"] = (isOpen ? 1 : 0) as CKRecordValue
        
        if !galleryPosts.isEmpty { //se nao tiver vazio, da pra inicializar no container normalmente
            record["galleryPosts"] = galleryPosts as CKRecordValue
        }
        
        if let coverURL = galleryCoverURL {
            let asset = CKAsset(fileURL: coverURL)
            record["galleryCover"] = asset
        }
        
        return record
        
    }
}
