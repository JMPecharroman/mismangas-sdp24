//
//  MangaView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 10/12/24.
//

import SwiftUI

struct MangaView: View {
    
    @State var vm: MangaViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 0.0) {
                MangaHeader(manga: vm.manga)
                LazyVStack(alignment: .leading) {
                    SectionHeader(text: "Mi colección")
                        .padding(.horizontal)
                    MangaCollectionStatusView(manga: vm.manga)
                    
                    SectionHeader(text: "Autores")
                        .padding(.horizontal)
                    MangaAuthorsCarrousel(authors: vm.manga.authors)

                    SectionHeader(text: "Categorías", button: "Ver todas") {
                        MangaCategoriesView(manga: vm.manga)
                    }
                    .padding(.horizontal)
                    MangaCategoriesGrid(manga: vm.manga)
                    
                    MangaInfoSection(manga: vm.manga)
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
            }
        }
        .background {
            MangaBackground(manga: vm.manga)
        }
        .navigationTitle(vm.manga.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MangaView(vm: MangaViewModel(.preview))
    }
}
