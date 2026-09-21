//
//  Post.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 14/09/26.
//

//eh minha primeira vez usando CloudKit. Vou me dar a liberdade de comentar mais o codigo

import Foundation
import CloudKit
import SwiftUI

struct Post {
    let postId: CKRecord.ID
    var postUserID: CKRecord.Reference //uma referencia!! tipo o @relationship do Swift Data? -> sim! oba!
    var postGalleryID: CKRecord.Reference //vamos usar o postUserID e o postGalleryID como referencia pro relacionamento entre user e gallery (ou seja o post é como o meio entre o user e a galeria)
    var postPhotoURL: URL? //como que eh essa porra? -> URL da imagem salva em disco que vamos passar como CKAsset 😎
    var postDescription: String?
    var postDate: Date
    var isPublic: Bool
    
    static let recordType = "Post" //isso aqui eh o nome da tabela no bd
    
    init?(record: CKRecord) { //lendo da nuvem
        guard let postUserID = record["postUserID"] as? CKRecord.Reference,
              let postGalleryID = record["postGalleryID"] as? CKRecord.Reference, //por que eu passo uma string para record?? -> o CKRecord funciona como um dicionario!! to atribuindo a string "postDescription" como chave pra a string que vai estar na variavel propriamente
              let postDate = record["postDate"] as? Date,
              let isPublic = record["isPublic"] as? Int64 else {
            return nil
        }
        
        self.postId = record.recordID
        self.postUserID = postUserID
        self.postGalleryID = postGalleryID
        self.postDate = postDate
        self.isPublic = (isPublic == 1) //acucar sintatico tem um if aqui dentro e pa
        
        self.postDescription = record["postDescription"] as? String //como postDescription eh opcional, da pra fazer um cast simples fora do guard let
        //eventualmente vai ter a logica pra baixar da nuvem e salvar no disco do iphone (memoria temporaria enquanto o user ta vendo a foto)
        if let asset = record["postPhoto"] as? CKAsset {//mhmmmmm
            self.postPhotoURL = asset.fileURL
        } else {
            self.postPhotoURL = nil
        }
    }
    
    func toRecord() -> CKRecord { //converte o modelo struct para CKRecord (aka salvando na nuvem)
        let record = CKRecord(recordType: Self.recordType, recordID: postId)
        record["postUserID"] = postUserID
        record["postGalleryID"] = postGalleryID
        record["postDate"] = postDate as CKRecordValue //transformando no tipo legivel pelo bd
        record["isPublic"] = (isPublic ? 1 : 0) as CKRecordValue
        
        if let postDescription = postDescription {
            record["postDescription"] = postDescription as CKRecordValue
        }
        
        if let photoURL = postPhotoURL { //desempacotando photoURL
            let asset = CKAsset(fileURL: photoURL) //sintaxe desse cacete (ckasset hahaaha)
            record["postPhoto"] = asset
        }
        
        return record
    }
}
