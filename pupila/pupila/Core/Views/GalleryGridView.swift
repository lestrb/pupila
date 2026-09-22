//
//  GalleryGridView.swift
//  pupila
//
//  Created by Vyvian Freitas on 22/09/26.
//

import SwiftUI
import UIKit

struct PostItem: Identifiable {
    let id = UUID()
    let imagem: UIImage
    let titulo: String
}


struct CardItemView: View {
    let item: PostItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(uiImage: item.imagem)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            if !item.titulo.isEmpty {
                Text(item.titulo)
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 4)
                    .padding(.bottom, 6)
            }
        }
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
struct MasonryGridView: View {
    var posts: [PostItem]
    
    var colunaEsquerda: [PostItem] {
        var itens: [PostItem] = []
        for i in 0..<posts.count {
            if i % 2 == 0 {
                itens.append(posts[i])
            }
        }
        return itens
    }
    
    var colunaDireita: [PostItem] {
        var itens: [PostItem] = []
        for i in 0..<posts.count {
            if i % 2 != 0 {
                itens.append(posts[i])
            }
        }
        return itens
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            LazyVStack(spacing: 12) {
                ForEach(colunaEsquerda) { post in
                    CardItemView(item: post)
                }
            }
            
            LazyVStack(spacing: 12) {
                ForEach(colunaDireita) { post in
                    CardItemView(item: post)
                }
            }
        }
        .padding(.horizontal, 12)
    }
}



