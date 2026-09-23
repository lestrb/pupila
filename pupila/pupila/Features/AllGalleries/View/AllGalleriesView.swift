//
//  AllGalleriesView.swift
//  pupila
//
//  Created by João Fernando Gama Barros on 17/09/26.
//

import SwiftUI

struct AllGalleriesView: View {
    
    @State var selected: SegmentedControlGalleryView.IsOpenFilter = .open
    
    var filteredGalleries: [Gallery] {
        
        Gallery.mockData.filter { gallery in
            
            selected == .open ? gallery.isOpen : !gallery.isOpen
            
        }
        
        // usar guard quando for usar dados reais
        
    }
    
    var body: some View {
        
       
        NavigationStack {
            
            VStack {
                SegmentedControlGalleryView(selected: $selected)
                
            }
            .padding()
            
            ScrollView {
                
                  
                
                    ForEach(filteredGalleries, id: \.galleryID) { gallery in
                        
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
