//
//  UserPostViewModel.swift
//  pupila
//
//  Created by Letícia Staudinger Ribeiro on 01/10/26.
//

import CloudKit
import Observation

@MainActor // Atualizações de UI ocorrem na thread principal
@Observable
class UserPostViewModel {
    var post: Post
    var author: User? // Começa nulo e é preenchido quando pegar da nuvem
    var gallery: Gallery?
    var isLoadingAuthor: Bool = false
    var isLoadingGallery: Bool = false
    
    private let userService: UserServiceProtocol
    private let galleryService: GalleryServiceProtocol
    
    // Injeta o Post inicial e o serviço
    init(post: Post, userService: UserServiceProtocol? = nil, galleryService: GalleryServiceProtocol? = nil) {
        self.post = post
        self.userService = userService ?? UserService() // Se a view não passar nenhum serviço, cria um
        self.galleryService = galleryService ?? GalleryService()
        
        // Assim que inicializar, já busca o autor daquele post
        Task { // Task é como se fosse uma bolha assíncrona independente
            await fetchAuthor()
        }
        
        // Separadas pra rodar simultaneamento
        Task {
            await fetchGallery()
        }
    }
    
    // Fetch com autor
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
    
    // Fetch com a gallery do post
    private func fetchGallery() async {
        isLoadingGallery = true
        do {
            let galleryID = post.postGalleryID.recordID
            self.gallery = try await galleryService.searchGalleries(by: galleryID)
        } catch {
            print("Erro ao buscar a galeria do post: \(error.localizedDescription)")
        }
        isLoadingGallery = false
    }
    
    // Funções para formatação do tipo Date pra String para a View
    
    // Transforma a data no formato "28 de maio"
    var formattedPostDate: String {
        post.postDate.formatted(
            .dateTime
            .day()
            .month(.wide) // Nome do mês por extenso
            .locale(Locale(identifier: "pt_BR"))
        )
    }
    
    // Transforma a data no formato "Fotografada em 27 de abril de 2026"
    var formattedPhotoDate: String {
        let dateString = post.postPhotoDate.formatted(
            .dateTime
            .day()
            .month(.wide)
            .year()
            .locale(Locale(identifier: "pt_BR"))
        )
        return "Fotografada em \(dateString)"
    }
}
