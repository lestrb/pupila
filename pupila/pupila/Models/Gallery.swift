//
//  Gallery.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 14/09/26.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Gallery: Identifiable {
    
    var galleryName: String
    var galleryPosts: [Post]
    var isOpen: Bool
    var galleryCover: Image
    
    init(galleryName: String, galleryPosts: [Post], isOpen: Bool, galleryCover: Image) {
        
        self.galleryName = galleryName
        self.galleryPosts = galleryPosts
        self.isOpen = isOpen
        self.galleryCover = galleryCover
    }
}
