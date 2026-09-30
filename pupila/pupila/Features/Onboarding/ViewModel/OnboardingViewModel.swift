//
//  OnboardingViewModel.swift
//  pupila
//
//  Created by Vyvian Freitas on 30/09/26.
//

import SwiftUI
import AuthenticationServices

@Observable
@MainActor
final class OnboardingViewModel {
    
    struct OnboardingItem {
        var id: Int
        var imageName: String
        var title: String
        var description: String
    }
    
    var currentPage: Int = 0
    var isLoading: Bool = false
    var errorMessage: String?
    
    let pages: [OnboardingItem] = [
        OnboardingItem(
            id: 0,
            imageName: "pupila_logo",
            title: "Galerias semanais",
            description: "Participe de uma comunidade ativa de fotógrafos em que a sua foto é vista."
        ),
        OnboardingItem(
            id: 1,
            imageName: "pupila_logo",
            title: "Sua visão sobre galerias",
            description: "Veja opções semanais de temas para participar de uma galeria compartilhada com outros fotógrafos."
        ),
        OnboardingItem(
            id: 2,
            imageName: "pupila_logo",
            title: "Não perca o prazo",
            description: "Fique atento ao limite do prazo de submissão para poder participar das galerias compartilhadas."
        )
    ]
    
    var isLastPage: Bool {
        currentPage == pages.count - 1
    }
    

    func nextPage() {
        guard !isLastPage else { return }
        currentPage += 1
    }
    
    func skipToLast() {
        currentPage = pages.count - 1
    }
    
    
  // implementar depois de joao e let concluirem as services
    func handleAppleSignInRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    func handleAppleSignInCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                errorMessage = "Falha ao processar credenciais da Apple."
                return
            }
            
            let userId = credential.user
            let email = credential.email
            let fullName = credential.fullName
            let identityToken = credential.identityToken
            
            print("Usuário autenticado: \(userId)")
            if let email { print("Email: \(email)") }
            if let fullName { print("Nome: \(fullName.formatted())") }
            
        case .failure(let error):
            
            let nsError = error as NSError
            if nsError.code != ASAuthorizationError.canceled.rawValue {
                self.errorMessage = error.localizedDescription
            }
            print("Erro no Apple Sign-In: \(error.localizedDescription)")
        }
    }
}

