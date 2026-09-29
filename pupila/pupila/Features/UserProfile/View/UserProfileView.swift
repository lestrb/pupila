//
//  UserProfileView.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 18/09/26.
//

import SwiftUI

struct UserProfileView: View {
    
    var body: some View {
        
        UserProfileViewDetail(user: User.mockData[0])
        
    }
    
}

#Preview {
    UserProfileView()
}
