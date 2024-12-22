//
//  SearchMangasView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 22/12/24.
//

import SwiftUI

struct SearchMangasView: View {
    
    static let viewTitle: String = "Buscar"
    
    @Environment(MangasViewModel.self) private var vm
    
    var body: some View {
        NavigationStack {
            List {
                if vm.mangas.isEmpty {
                    if vm.isLoadingMangas {
                        LoadingListCell()
                    } else {
                        NoResultsView()
                    }
                } else {
                    Section {
                        ForEach(vm.mangas) { manga in
                            MangaListCell(manga: manga)
                                .onAppear {
                                    vm.mangaAppear(manga)
                                }
                        }
                    } footer: {
                        if vm.canLoadMoreMangas {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .controlSize(.regular)
                                Text("Cargando más resultados...")
                                Spacer()
                            }
                            .padding()
                            .onAppear {
                                vm.loadMoreMangas()
                            }
                        }
                    }
                }
            }
            .navigationTitle(Self.viewTitle)
            .onAppear {
                vm.onAppear()
            }
        }
    }
}

#Preview {
    SearchMangasView()
        .environment(MangasViewModel(repository: .preview))
}
