//
//  GalleryCardView.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 17/09/26.
//

import SwiftUI

struct GalleryCardView: View {
    var body: some View {
        
        
        var galleryName = "Casamento"
        var galleryPhotoCounter = 2
        var galleryCover = "casamento"
        var galleryDeadline = 2

        
        ZStack(alignment: .bottomTrailing) {
            
            HStack {
                
                ZStack {
                    
                    Image(galleryCover)
                        .colorMultiply(.gray)
                    
                        VStack(spacing: 30) {
                            
                            VStack { Text(galleryName)
                                    .bold()
                                    .font(.largeTitle)
                                Text("\(galleryPhotoCounter) \(galleryPhotoCounter == 1 ? "foto" : "fotos")") .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            // variável de quantidade de fotos in casamento
                        }
                }
                
            }
            .frame(width: 350, height: 160)
            .cornerRadius(30)
            
            GalleryDeadlineDetailView()
            //GalleryCheckButton

        }
        .foregroundStyle(.white)
//        teste

        

    }
}

#Preview {
    GalleryCardView()
}
