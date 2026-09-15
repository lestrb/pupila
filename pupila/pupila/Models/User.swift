//
//  User.swift
//  pupila
//
//  Created by Michel de Oliveira Silva on 14/09/26.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class User {
    
    var UserName: String
    var userPic: Image
    var userBio: String
    var userLinks: [String]
    var userPosts: [Post]
    
    
    init (UserName: String, userPic: Image, userBio: String, userLinks: [String], userPosts: [Post] = [] ){
        
        self.UserName = UserName
        self.userPic = userPic
        self.userBio = userBio
        self.userLinks = userLinks
        self.userPosts = userPosts

    }
}
