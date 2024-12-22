//
//  MangasListContent.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 22/12/24.
//

import SwiftUI

struct MangasListContent: View {
    
    let vm: MangasListViewModel
    
    var body: some View {
        if vm.mangas.isEmpty {
            if vm.isLoadingMangas {
                LoadingListCell()
            } else {
                NoResultsView()
            }
        } else {
            ForEach(vm.mangas) { manga in
                MangaListCell(manga: manga)
                    .onAppear {
                        vm.mangaAppear(manga)
                    }
            }
            if vm.canLoadMoreMangas {
                Section {
                    HStack {
                        Spacer()
                        ProgressView()
                            .controlSize(.small)
                        Text("Cargando más resultados...")
                            .font(.caption)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .onAppear {
                        vm.loadMoreMangas()
                    }
                }
                .listRowBackground(Color.clear)
            }
        }
    }
}

#Preview {
    MangasListContent(vm: MangasViewModel(repository: .preview))
}
