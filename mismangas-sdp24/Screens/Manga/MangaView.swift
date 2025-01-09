//
//  MangaView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 10/12/24.
//

import SwiftUI

struct MangaView: View {
    @Environment(\.modelContext) var modelContext
    
    @State var vm: MangaViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 0.0) {
                MangaHeader(manga: vm.manga)
                LazyVStack(alignment: .leading) {
                    MangaCollectionStatusView(manga: vm.manga)
                    
                    SectionHeader(text: "Autores")
                        .padding(.horizontal)
                    
                    AuthorsCarrousel(authors: vm.manga.authors)

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
        .onAppear {
            vm.onAppear(modelContext: modelContext)
        }
        .blurImageBackground(url: vm.manga.mainPictute)
        .navigationTitle(vm.manga.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension MangaView {
    init(_ manga: Manga) {
        self = MangaView(vm: .init(manga))
    }
}

#Preview {
    NavigationStack {
        MangaView(vm: MangaViewModel(.preview))
    }
}
