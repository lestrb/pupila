//
//  GalleryDeadlineDetailView.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 18/09/26.
//

import SwiftUI

struct GalleryDeadlineDetailView: View {

    
    var body: some View {
        
    var galleryDeadline = 1

    
        Label("\(galleryDeadline) \(galleryDeadline == 1 ? "dia restante" : "dias restantes")", systemImage: "timer")
            .fontWeight(.semibold)
            .font(.caption)
            .padding()
        
        }
        
    }

#Preview {
    GalleryDeadlineDetailView()
}
