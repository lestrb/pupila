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
                TextField("Adcione a camera da fotografia", text: $postPhotoCamera, axis: .vertical)
                    .lineLimit(1...2)
                    .onChange(of: postPhotoCamera){
                        postPhotoCamera = String(postPhotoCamera.prefix(55))
                        }

                    .textFieldStyle(.plain)
                    .padding(15)
                    .background(.capsulePupila.opacity(0.24), in: .buttonBorder)
            } header: {
                Text("Camera")
                    .foregroundStyle(Color.primary)
                    .textCase(nil)
                    .font(.body)
            }
            Section(){
                TextField("Adcione o local da fotografia", text: $postPhotoPlace, axis: .vertical)
                    .lineLimit(1...3)
                    .onChange(of: postPhotoPlace){
                        postPhotoPlace = String(postPhotoPlace.prefix(78))
                        }
                    .textFieldStyle(.plain)
                    .padding(15)
                    .background(.capsulePupila.opacity(0.24), in: .buttonBorder)
            } header: {
                Text("Local")
                    .foregroundStyle(Color.primary)
                    .textCase(nil)
                    .font(.body)
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
//        DatePicker(
//            "Data e Hora:", //titulo do picker
//            selection: $dataSelecionada,
//            displayedComponents: [.date, .hourAndMinute]
//            )
//            .datePickerStyle(.compact)
        YellowButton(titulo: "Seguinte") {
        }
        
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

