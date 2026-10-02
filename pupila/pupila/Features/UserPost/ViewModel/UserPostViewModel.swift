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
        Task { // Task é como se fosse uma bolha assíncrona independente
            await fetchAuthor()
        }
    }
    
    private func fetchAuthor() async {
        isLoadingAuthor = true
        do {
            let userID = post.postUserID.recordID // Extrai o ID da referência para buscarmos o User
            self.author = try await userService.fetchUser(by: userID) // Busca os dados do perfil pelo ID
        } catch {
            print("Erro ao buscar o autor do post: \(error.localizedDescription)")
        }
        isLoadingAuthor = false
    }
}
