//
//  Post.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 14/09/26.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Post: Identifiable {
    
    var postUser: User 
    var postPhoto: Image
    var postDescription: String?
    var postDate: Date
    var isPublic: Bool
    
    init(postUser: User, postPhoto: Image, postDescription: String? = nil, postDate: Date, isPublic: Bool) {
        
        self.postUser = postUser
        self.postPhoto = postPhoto
        self.postDescription = postDescription
        self.postDate = postDate
        self.isPublic = isPublic
    }
    
}
