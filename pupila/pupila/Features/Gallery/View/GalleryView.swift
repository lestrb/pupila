//
//  GalleryView.swift
//  pupila
//
//  Created by João Fernando Gama Barros on 17/09/26.
//

import SwiftUI

struct GalleryView: View {
    
    let gallery: Gallery

    var body: some View {
        
        Text(gallery.galleryName)
    }
}

#Preview {
//    GalleryView(gallery: gallery)
}
