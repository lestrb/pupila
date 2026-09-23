//
//  AllGalleriesView.swift
//  pupila
//
//  Created by João Fernando Gama Barros on 17/09/26.
//

import SwiftUI

struct AllGalleriesView: View {
    
    
    var body: some View {
    
        
//        Picker("Abertas")
//            .pickerStyle(SegmentedPickerStyle)
     
        NavigationStack {
            
            ScrollView {
    
                    ForEach(Gallery.mockData, id: \.galleryID) { gallery in
                        
                        GalleryCardView(galleryName: gallery.galleryName, galleryCoverURL: gallery.galleryCoverURL, isOpen: (gallery.galleryCoverURL == nil), galleryPhotoCounter: gallery.galleryPhotoCounter)
                    
                    
                    }

            }
            .padding()
            .navigationTitle("Galerias")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    
              NavigationLink(destination: UserProfileView()) {
                            Image(systemName: "person")
                        }
                }
                
                
            }
            //ForEach - If Abertas
        }

        
        
    }
}

#Preview {
    AllGalleriesView()
}
