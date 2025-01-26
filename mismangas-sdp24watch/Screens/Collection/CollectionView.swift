//
//  CollectionView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import SwiftData
import SwiftUI

struct CollectionView: View {
    
    static let viewTitle: String = "Colección"
    
    @Environment(CollectionViewModel.self) private var collectionVM
    
    @Query(sort: \CollectionMangaSD.title) var mangas: [CollectionMangaSD]
    
    var body: some View {
        List {
            if mangas.isEmpty {
                CollectionIsEmpty()
            } else {
                ForEach(mangas) { manga in
                    CollectionMangaListCell(manga: manga.toCollectionManga)
                }
            }
        }
        .navigationTitle(Self.viewTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CollectionView()
}
