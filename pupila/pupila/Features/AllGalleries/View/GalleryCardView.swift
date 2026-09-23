//
//  GalleryCardView.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 17/09/26.
//

import SwiftUI

struct GalleryCardView: View {
    
    var galleryName: String
    var galleryCoverURL: URL?
    var isOpen: Bool
    var galleryPhotoCounter: Int64
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            HStack {
                
                ZStack {
                    
                    if let galleryCoverURL = galleryCoverURL {
                        AsyncImage(url: galleryCoverURL) { image
                            
                            in image
                                .resizable()
                                .scaledToFill()
                                .colorMultiply(.gray)
                            
                        } placeholder: {
                            Color.black
                        }
                    } else {
                            Color.black
                        }
                        
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
                
                GalleryDeadlineDetailView(galleryDeadline: 2)
                //GalleryCheckButton
                
            }
            .foregroundStyle(.white)
            //        teste
            
            
            
        }
    }

#Preview {
    GalleryCardView(galleryName: "Casamento", galleryCoverURL: nil, isOpen: true, galleryPhotoCounter: 12)
}
