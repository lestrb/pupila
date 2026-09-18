//
//  UserProfileView.swift
//  pupila
//
//  Created by João Fernando Gama Barros on 17/09/26.
//

import SwiftUI

struct UserProfileViewDetail: View {
    var body: some View {
        
        var userName = "Michel"
        var userPic = "fotografoprofile"
        var userBio = "A persistência é o caminho seguro para o êxito profissional e pessoal. Cada pequeno obstáculo superado"
        
        
        VStack(alignment: .leading){
            
            HStack{
                
                
                Image(userPic)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 105, height: 115)
                    .clipShape(Circle())
                
                
                VStack(alignment: .leading) {
                    Text(userName)
                        .fontWeight(.bold)
                    Text(userBio)
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                }
                .padding(10)
                
            }
            
            HStack {
                Text("Conecte-se comigo:")
                Button("Link", systemImage: "link", action: { })
                    .labelStyle(.iconOnly)
                
                
            }
        }
        .frame(width: 356, height: 159)
        
    }
}


#Preview {
    UserProfileViewDetail()
}
