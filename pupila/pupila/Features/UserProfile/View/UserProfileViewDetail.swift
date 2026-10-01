//
//  UserProfileView.swift
//  pupila
//
//  Created by João Fernando Gama Barros on 17/09/26.
//

import SwiftUI

struct UserProfileViewDetail: View {
    
    var user: User

    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack{ 
                
                if let userPic = user.userPic {
                    AsyncImage(url: userPic) { image in
                         image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 115)
                            .clipShape(Circle())
                        
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                    }
                } else {
                    
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 115)
                        .clipShape(Circle())
                    
                }
                
                VStack(alignment: .leading) {
                    Text(user.name)
                        .fontWeight(.bold)
                    Text(user.userBio)
                        .font(.subheadline)
                        .fontWeight(.light)

                    
                }
                .frame(width: 230, height: 120)
                .padding()
                
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
    UserProfileViewDetail(user: User.mockData[0])
}
