//
//  CollectionMangaView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 3/1/25.
//

import SwiftUI

struct CollectionMangaView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State var vm: CollectionMangaViewModel
    
    @State private var showDeleteConfirmation: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 16.0) {
                if let error = vm.error {
                    ErrorView(error: error)
                }
                if let collectionManga = vm.data {
                    CollectionMangaHeaderView(collectionManga: collectionManga)
                    if collectionManga.totalVolumes > 0 {
                        CollectionMangaGaugesView(collectionManga: collectionManga)
                    } else {
                        HStack {
                            Image(systemName: "xmark.circle")
                                .foregroundStyle(.red)
                            Text("No hay volúmenes disponibles")
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .cardBackground()
                    }
                }
                CollectionMangaVolumesGrid(vm: $vm)
            }
            .padding()
        }
        .navigationTitle(vm.data?.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {
                    Label("Eliminar", systemImage: "trash")
                        .foregroundStyle(.red)
                }
                .tint(.red)
            }
        }
        .refreshable {
            vm.refresh()
        }
        .loading(vm.isLoading)
        .blurImageBackground(url: vm.data?.cover)
        .alert("Eliminar manga", isPresented: $showDeleteConfirmation) {
            Button(role: .destructive) {
                vm.deleteFromCollection()
            } label: {
                Text("Eliminar")
            }
        } message: {
            Text("¿Estás seguro de eliminar \(vm.data?.title ?? "") de tu colección? Los datos no se podrán recuperar")
        }
        .onAppear {
            vm.onAppear(modelContext: modelContext)
        }
        .onChange(of: vm.entityIsDeleted) {
            guard vm.entityIsDeleted else { return }
            dismiss()
        }
    }
}

extension CollectionMangaView {
    init(_ collectionManga: CollectionManga) {
        self.init(vm: .init(data: collectionManga))
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        CollectionMangaView(vm: .preview)
    }
}
