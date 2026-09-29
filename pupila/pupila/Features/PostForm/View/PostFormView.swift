//
//  PostFormView.swift
//  pupila
//
//  Created by João Fernando Gama Barros on 17/09/26.
//

import SwiftUI
import PhotosUI

struct PostFormView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showNextView = false
    @State private var postPhoto: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var postDescription = ""
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        NavigationStack {
            VStack{
                Form{
                    PhotosPicker(
                        selection: $postPhoto,
                        matching: .images
                    ) {
                        if let selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.secondarySystemBackground))
                                .frame(maxWidth: .infinity)
                                .aspectRatio(4/3, contentMode: .fit)
                                .overlay {
                                    Text("Upload de mídia")
                                        .foregroundStyle(.secondary)
                                }
                        }

                    }
                    .padding()
                    .onChange(of: postPhoto) { _, newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImage = UIImage(data: data)
                            }
                        }
                    }
                    Section(){
                        TextField("Adicione uma descrição", text: $postDescription, axis: .vertical)
                            .lineLimit(1...4)
                            .focused($isTextFieldFocused)
                            .textFieldStyle(.plain)
                            .padding(15)
                            .background(.capsulePupila.opacity(0.24), in: .buttonBorder)
                            .onChange(of: postDescription){
                                    postDescription = String(postDescription.prefix(150))
                                }
                    }
                    header: {
                        HStack{
                            Text("Descrição:")
                                .foregroundStyle(Color.primary)
                                .textCase(nil)
                                .font(.body)
                            Spacer()
                                
                            Text("\(postDescription.count)/150")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(.white)
                if !isTextFieldFocused {
                    YellowButton(titulo: "Seguinte") {
                        showNextView = true
                    }
                    .disabled(selectedImage == nil)
                }
                
                
            }
                    .navigationTitle("Adicionar Foto")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationDestination(isPresented: $showNextView){
                        PostFormViewNext {
                            dismiss()
                        }                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            if isTextFieldFocused {
                                Button("Concluir", systemImage: "checkmark") {
                                    isTextFieldFocused = false
                                }
                                // se quiserem tentar pintar o botao da toolbar

//                                .buttonStyle(.glassProminent)
//                                .buttonBorderShape(.circle)
//                                .tint(.yellowPupila)
//                                .foregroundStyle(.black)
                            } else {
                                Button("Fechar", systemImage: "xmark") {
                                    dismiss()
                                }
                            }
                        }
                    }
                    }
        }
    }
struct PostFormPreview: View {
    @State private var showPostForm = false

    var body: some View {
        Button("Adicionar Foto") {
            showPostForm = true
        }
        .sheet(isPresented: $showPostForm) {
            PostFormView()
        }
    }
}


#Preview {
    PostFormPreview()
}
