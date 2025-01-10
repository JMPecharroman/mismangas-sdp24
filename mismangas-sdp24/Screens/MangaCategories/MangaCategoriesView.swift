//
//  MangaCategoriesView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/12/24.
//

import SwiftUI

struct MangaCategoriesView: View {
    
    let manga: Manga
    
    var body: some View {
        List {
            if manga.categories.isEmpty {
                ContentUnavailableView(
                    "Sin categorías",
                    systemImage: "xmark.circle",
                    description: Text("No se han encontrado categorías para \(manga.title)")
                )
            } else {
                ForEach(CategoryGroup.allCases, id: \.self) { group in
                    if !manga.categories.filter({ $0.group == group }).isEmpty {
                        Section(group.label) {
                            ForEach(manga.categories.filter({ $0.group == group })) { category in
                                NavigationLink(value: category) {
                                    Text(category.name)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(manga.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MangaCategoriesView(manga: .preview)
    }
}
