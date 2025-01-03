//
//  CollectionView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 30/12/24.
//

import SwiftData
import SwiftUI

struct CollectionView: View {
    
    static let viewTitle: String = "Colección"
    
    @Environment(\.modelContext) var modelContext
    @Environment(CollectionViewModel.self) private var collectionVM
    
    @Query var mangas: [CollectionMangaSD]
    
    @State private var showDeleteConfirmation: Bool = false
    @State private var selectedManga: CollectionMangaSD?
    
    var body: some View {
        NavigationStack {
            List {
                if let error = collectionVM.error {
                    Section {
                        ErrorListCell(error: error)
                    }
                }
                if mangas.isEmpty {
                    CollectionIsEmpty()
                } else {
                    ForEach(mangas) {
                        CollectionMangaListCell(manga: $0.toCollectionManga)
                    }
                    .onDelete {
                        guard let index = $0.first else { return }
                        selectedManga = mangas[index]
                        showDeleteConfirmation = true
                    }
                }
            }
            .navigationTitle(Self.viewTitle)
            .navigationDestinations()
//            .refreshable {
            // Está el query
//                collectionVM.refresh()
//            }
            .alert("Eliminar manga", isPresented: $showDeleteConfirmation) {
                Button(role: .destructive) {
                    guard let id = selectedManga?.id else { return }
                    collectionVM.deleteManga(withId: id)
                } label: {
                    Text("Eliminar")
                }
            } message: {
                Text("¿Estás seguro de eliminar \(selectedManga?.title ?? "-") de tu colección? Los datos no se podrán recuperar")
            }
            .loading(collectionVM.isLoading)
            .onAppear {
                collectionVM.onAppear(modelContext: modelContext)
            }
        }
    }
}

#Preview(traits: .sampleData) {
    CollectionView()
        .environment(CollectionViewModel(repository: .preview))
}
