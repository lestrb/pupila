//
//  GalleryMockData.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 22/09/26.
//

import Foundation

extension Gallery {
    
    static let mockData: [Gallery] = [
        Gallery(
                    galleryName: "Casamento",
                    galleryDeadline: Calendar.current.date(byAdding: .day, value: 5, to: Date()) ?? Date(),
                    galleryPhotoCounter: 50
                ),
        
        Gallery(
                    galleryName: "Rua",
                    galleryDeadline: Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date(),
                    galleryPhotoCounter: 13
                ),
        
        Gallery(
                    galleryName: "P&B",
                    galleryDeadline: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date(),
                    galleryPhotoCounter: 20
                )
        
    ]
    
}


extension User {
    
    static let mockData: [User] = [
        
        User(
            
            appleID: "mock-apple-id-001", name: "Michel", email: "chellolivy@email.com", userName: "chellsilva")
        
    ]
    
    
}
