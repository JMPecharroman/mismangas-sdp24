//
//  MangasListView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

import SwiftUI

struct MangasListView: View {
    
    static let viewTitle: String = "Mangas"
    
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
    MangasListView()
        .environment(MangasViewModel(repository: .preview))
}
