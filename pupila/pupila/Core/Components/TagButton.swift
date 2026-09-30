//
//  TagButton.swift
//  pupila
//
//  Created by Felipe José Batista Farias on 9/29/26.
//

import SwiftUI

        struct TagButton: View {
            let titulo: String
            let acao: () -> Void
            
            var body: some View {
                Button(action: acao) {
                    Text(titulo)
                                    .foregroundStyle(.blackPupila)
                }
                .controlSize(.small)
                .buttonStyle(.borderedProminent)
                .tint(.capsulePupila.opacity(0.24))

            }
        }

#Preview {
    TagButton(
        titulo: "Casamento"
    ) {
    }
}
