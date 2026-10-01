//
//  UserPostViewModel.swift
//  pupila
//
//  Created by Letícia Staudinger Ribeiro on 01/10/26.
//

import Foundation
import CloudKit

@MainActor // Atualizações de UI ocorrem na thread principal
@Observable
class UserPostViewModel {
    var post: Post
    var author: User? // Começa nulo e é preenchido quando pegar da nuvem
    var isLoadingAuthor: Bool = false
    
    private let userService: UserServiceProtocol
        
    // Injeta o Post inicial e o serviço
    init(post: Post, userService: UserServiceProtocol = UserService()) {
        self.post = post
        self.userService = userService
        
        // Assim que inicializar, já busca o autor daquele post
        Task {
            await fetchAuthor()
        }
    }
}
