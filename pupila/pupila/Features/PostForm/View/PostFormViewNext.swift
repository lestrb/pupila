//
//  PostFormViewNext.swift
//  pupila
//
//  Created by Felipe José Batista Farias on 9/23/26.
//

import SwiftUI

struct PostFormViewNext: View {
    @State private var postPhotoCamera = ""
    @State private var postPhotoPlace = ""
    @State private var dataSelecionada = Date()
    var body: some View {
        VStack{
            
        Form{
            Section(){
                TextField("Adicione a camera da fotografia", text: $postPhotoCamera, axis: .vertical)
                    .lineLimit(1...2)
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
            Section{
                        DatePicker(
                            "Data e Hora:", //titulo do picker
                            selection: $dataSelecionada,
                            displayedComponents: [.date, .hourAndMinute]
                            )
                            .datePickerStyle(.compact)
            }
        }
        .scrollContentBackground(.hidden)
        .background(.white)
        YellowButton(titulo: "Postar") {
        }
        .disabled(
            postPhotoCamera.isEmpty || postPhotoPlace.isEmpty
        )
//        .disabled(
//            postPhotoCamera.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
//            postPhotoPlace.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
//        )
        
    }
        .navigationTitle("Adicionar Foto")
        .navigationBarTitleDisplayMode(.inline)
}
}

#Preview {
    NavigationStack{
        PostFormViewNext()
    }
}

