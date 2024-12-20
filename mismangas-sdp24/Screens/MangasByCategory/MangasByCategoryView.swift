//
//  CategoryView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import SwiftUI

struct MangasByCategoryView: View {
    
    @State var vm: CategoryViewModel
    
    var body: some View {
        List {
            if vm.mangas.isEmpty {
                if vm.isLoading {
                    LoadingListCell()
                } else {
                    ContentUnavailableView(
                        "Sin resultados",
                        systemImage: "xmark.circle",
                        description: Text("No se han encontrado mangas en la categoría \(vm.category.name)")
                    )
                }
            } else {
                Section {
                    ForEach(vm.mangas) { manga in
                        MangaListCell(manga: manga)
                    }
                } footer: {
                    if vm.canLoadMore {
                        HStack {
                            Spacer()
                            ProgressView()
                                .controlSize(.regular)
                            Text("Cargando más resultados...")
                            Spacer()
                        }
                        .padding()
                        .onAppear {
                            vm.loadMore()
                        }
                    }
                }
            }
        }
        .navigationTitle(vm.category.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            vm.onAppear()
        }
    }
}

#Preview {
    NavigationStack {
        MangasByCategoryView(vm: .preview)
    }
}
