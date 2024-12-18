//
//  MangaCategoriesGrid.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/12/24.
//

import SwiftUI

struct MangaCategoriesGrid: View {
    
    let manga: Manga
    
    private let columns = [
        GridItem(.adaptive(minimum: 90.0, maximum: 120.0), spacing: 4.0)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 4.0) {
            ForEach(manga.categories, id: \.self) { category in
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
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

#Preview {
    MangaCategoriesGrid(manga: .preview)
}
