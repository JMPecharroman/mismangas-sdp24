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
    
    @AppStorage(UserDefaultsKey.userIsLogged.rawValue) private var userIsLogged: Bool = false
    
    @Environment(\.modelContext) var modelContext
    @Environment(CollectionViewModel.self) private var collectionVM
    @Environment(SyncViewModel.self) private var syncVM
    
    @Query(sort: \CollectionMangaSD.title) var mangas: [CollectionMangaSD]
    
    @State private var showDeleteConfirmation: Bool = false
    @State private var showLoginSheet: Bool = false
    @State private var selectedManga: CollectionMangaSD?
    
    var body: some View {
        NavigationStack {
            List {
                if let error = collectionVM.error {
                    Section {
                        ErrorListCell(error: error)
                    }
                }
                if !userIsLogged {
                    Section {
                        Button {
                            showLoginSheet.toggle()
                        } label: {
                            Text("Inicia sesión para mantener tu colección sincronizada")
                        }
                    } header: {
                        Text("Sugerencia")
                    }
                }
                if mangas.isEmpty {
                    CollectionIsEmpty()
                } else {
                    ForEach(mangas) { manga in
                        CollectionMangaListCell(manga: manga.toCollectionManga)
                            .swipeActions {
                                Button {
                                    selectedManga = manga
                                    showDeleteConfirmation = true
                                } label: {
                                    Text("Eliminar")
                                }
                                .tint(.red)
                            }
                    }
                }
            }
            .navigationTitle(Self.viewTitle)
            .navigationDestinations()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showLoginSheet.toggle()
                    } label: {
                        Label("Cuenta", systemImage: "person.crop.circle")
                    }
                }
            }
            .refreshable {
                // Está el query
//                collectionVM.refresh()
                syncVM.refresh()
            }
            .sheet(isPresented: $showLoginSheet) {
                LoginView()
            }
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
            .loading(collectionVM.isLoading || syncVM.isLoading)
            .onAppear {
                collectionVM.onAppear(modelContext: modelContext)
                syncVM.onAppear(modelContext: modelContext)
            }
        }
    }
}

#Preview(traits: .sampleData) {
    CollectionView()
        .environment(CollectionViewModel(repository: .preview))
}
