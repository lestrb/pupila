//
//  GalleryCardView.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 17/09/26.
//

import SwiftUI

struct GalleryCardView: View {
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            
            HStack {
                
                ZStack {
                    
                    Image("casamento")
                        .colorMultiply(.gray)
                    
                        VStack(spacing: 30) {
                            
                            VStack { Text("Casamento")
                                    .bold()
                                    .font(.largeTitle)
                                Text("30 fotos")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            // variável de quantidade de fotos in casamento
                        }
                }
                
            }
            .frame(width: 350, height: 160)
            .cornerRadius(30)
            
            Image(systemName: "checkmark.circle.fill")
                .padding()
            //GalleryCheckButton

        }
        .foregroundStyle(.white)
//        teste

        

    }
}

#Preview {
    GalleryCardView()
}
