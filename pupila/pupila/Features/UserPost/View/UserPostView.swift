//
//  UserPostView.swift
//  pupila
//
//  Created by João Fernando Gama Barros on 17/09/26.
//

import SwiftUI

struct UserPostView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack{
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.gray)
                    
                    Text("Michel Silva")
                        .font(.body)
                    
                    Spacer()
                    
                    Text("28 de Maio")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                }
                .padding(.horizontal, 20)
                
                Image("casamento")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                
                Text("Casamento de Leticia e Ruany")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                
                VStack(alignment: .leading){
                    
                Text("Fotografada em 27 de Abril de 2026")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    
                Text("Nikon 9D7500")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                
                TagButton(titulo: "Casamento") {
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)


                    
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button{
                    
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        UserPostView()
    }
}
