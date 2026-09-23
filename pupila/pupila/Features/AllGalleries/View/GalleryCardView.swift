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
    var galleryDeadline: Date
    
    var daysRemaining: Int {
        Calendar.current.dateComponents([.day], from: Date(), to: galleryDeadline).day ?? 0 }

    
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
                
            if isOpen {
                Label(
                    "\(daysRemaining) \(daysRemaining == 1 ? "dia restante" : "dias restantes")", systemImage: "timer")
                    .fontWeight(.semibold)
                    .font(.caption)
                    .padding()
                //GalleryCheckButton
              }
            }
            .foregroundStyle(.white)
            //        teste
            
            
            
        }
    }

#Preview {
    GalleryCardView(galleryName: "Casamento", galleryCoverURL: nil, isOpen: true, galleryPhotoCounter: 12, galleryDeadline: .now)
}
