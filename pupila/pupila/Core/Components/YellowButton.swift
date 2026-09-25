//
//  YellowButton.swift
//  pupila
//
//  Created by Felipe José Batista Farias on 9/23/26.
//

import SwiftUI

struct YellowButton: View {
    let titulo: String
    let acao: () -> Void
    
    var body: some View {
        Button(action: acao) {
            Text(titulo)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
        }
        .controlSize(.large)
        .buttonStyle(.glassProminent)
        .tint(.yellowPupila)
        .padding(.horizontal, 35)
    }
}

#Preview {
    YellowButton(
        titulo: "Criar"
    ) {
    }
}
