//
//  MangaCategoriesGrid.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/12/24.
//

import SwiftUI

struct MangaCategoriesGrid: View {
    
    let manga: Manga
    
    var body: some View {
        LazyVGrid(columns: .adaptive(minimum: 90.0, maximum: 120.0, spacing: 4.0), spacing: 4.0) {
            ForEach(manga.categories, id: \.self) { category in
                NavigationLink {
                    MangasByCategoryView(category)
                } label: {
                    Text(category.name)
                        .font(.caption)
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .frame(height: 32.0)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background {
                            Capsule(style: .continuous)
                                .fill(Color(.systemGray5))
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

#Preview {
    MangaCategoriesGrid(manga: .preview)
}
