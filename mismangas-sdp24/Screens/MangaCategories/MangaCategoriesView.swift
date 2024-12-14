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
            Section("Categorías") {
                NavigationLink {
                    Text("Terror")
                } label: {
                    Text("Terror")
                }
            }
            if !manga.themes.isEmpty {
                Section("Temáticas") {
                    ForEach(manga.themes) { theme in
                        NavigationLink {
                            Text(theme.name)
                        } label: {
                            Text(theme.name)
                        }
                    }
                }
            }
            Section("Demografía") {
                NavigationLink {
                    Text("Terror22")
                } label: {
                    Text("Terrr2")
                }
            }
        }
        .navigationTitle(manga.title)
    }
}

#Preview {
    NavigationStack {
        MangaCategoriesView(manga: .preview)
    }
}
