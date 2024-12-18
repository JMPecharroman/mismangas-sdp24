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
                    VStack {
                        ProgressView()
                            .controlSize(.large)
                            .padding()
                        Text("Cargando...")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding()
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
                        NavigationLink {
                            MangaView(vm: .init(manga))
                        } label: {
                            MangaListCell(manga: manga)
                        }
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
            vm.viewAppear()
        }
    }
}

#Preview {
    NavigationStack {
        MangasByCategoryView(vm: .preview)
    }
}
