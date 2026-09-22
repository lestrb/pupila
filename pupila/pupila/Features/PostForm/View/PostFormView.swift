//
//  PostFormView.swift
//  pupila
//
//  Created by João Fernando Gama Barros on 17/09/26.
//

import SwiftUI
import PhotosUI

struct PostFormView: View {
    @State private var postPhoto: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var postDescription = ""
    var body: some View {
        NavigationStack {
            VStack{
                PhotosPicker(
                    selection: $postPhoto,
                    matching: .images
                ) {
                    if let selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 220, height: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.secondarySystemBackground))
                            .frame(width: 220, height: 250)
                            .overlay {
                                Text("Upload de mídia")
                                    .foregroundStyle(.secondary)
                            }
                    }

                }
                .onChange(of: postPhoto) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImage = UIImage(data: data)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text("Descrição")
                    

                }
                
            }
                    .navigationTitle("Adicionar Foto")
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PostFormView()
}
