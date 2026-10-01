//
//  PostFormViewNext.swift
//  pupila
//
//  Created by Felipe José Batista Farias on 9/23/26.
//

import SwiftUI

struct PostFormViewNext: View {
    @Environment(\.dismiss) private var dismiss
    @State private var postPhotoCamera = ""
    @State private var postPhotoPlace = ""
    @State private var dataSelecionada = Date()
    @FocusState private var isTextFieldFocused: Bool
    let onClose: () -> Void
    var body: some View {
        VStack{
            
        Form{
            Section(){
                TextField("Adicione a camera da fotografia", text: $postPhotoCamera, axis: .vertical)
                    .lineLimit(1...2)
                    .focused($isTextFieldFocused)
                    .submitLabel(.done)
                    .onChange(of: postPhotoCamera){
                        postPhotoCamera = String(postPhotoCamera.prefix(55))
                        }

                    .textFieldStyle(.plain)
                    .padding(15)
                    .background(.capsulePupila.opacity(0.24), in: .buttonBorder)
                
            } header: {
                HStack{
                    Text("Camera:")
                        .foregroundStyle(Color.primary)
                        .textCase(nil)
                        .font(.body)
                    Spacer()
                    Text("\(postPhotoCamera.count)/55")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Section(){
                TextField("Adicione o local da fotografia", text: $postPhotoPlace, axis: .vertical)
                    .lineLimit(1...3)
                    .focused($isTextFieldFocused)
                    .onChange(of: postPhotoPlace){
                        postPhotoPlace = String(postPhotoPlace.prefix(75))
                        }
                    .textFieldStyle(.plain)
                    .padding(15)
                    .background(.capsulePupila.opacity(0.24), in: .buttonBorder)
            } header: {
                HStack{
                    Text("Local:")
                        .foregroundStyle(Color.primary)
                        .textCase(nil)
                        .font(.body)
                    Spacer()
                    Text("\(postPhotoPlace.count)/75")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
            }
            Section(){
                VStack(alignment: .leading){
                    Text("Data e Hora:")
                        .padding(.bottom, 20)
                        
                    DatePicker(
                        "", //titulo do picker
                        selection: $dataSelecionada,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.compact)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(.white)
            if !isTextFieldFocused {
                YellowButton(titulo: "Postar") {
                }
                .disabled(
                    postPhotoCamera.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                    postPhotoPlace.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                )
            }
        
    }
        .navigationTitle("Adicionar Foto")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if isTextFieldFocused {
                        isTextFieldFocused = false
                    } else {
                        onClose()
                    }
                } label: {
                    Image(systemName: isTextFieldFocused ? "checkmark" : "xmark")
//                        .foregroundStyle(isTextFieldFocused ? .yellowPupila : .primary)
                    // se quiserem tentar pintar o botao da toolbar
                }
            }
        }
        
}
}

#Preview {
    NavigationStack{
        PostFormViewNext(){
        }
    }
}

