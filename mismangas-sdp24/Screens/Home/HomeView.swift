//
//  HomeView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import SwiftUI

struct HomeView: View {
    
    static let viewTitle: String = "Inicio"
    
    @Environment(AuthorsViewModel.self) private var authorsVM
    @Environment(MangasViewModel.self) private var mangasVM
    
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading) {
                    SectionHeader(text: "Destacados")
                        .padding(.horizontal)
                    if mangasVM.bestMangas.isEmpty {
                        VStack {
                            ProgressView()
                                .controlSize(.extraLarge)
                                .padding()
                        }
                        .frame(height: 225.0)
                        .frame(maxWidth: .infinity)
                    } else {
                        MangasCarrousel(mangas: mangasVM.bestMangas)
                    }
                    SectionHeader(text: "Autores")
                        .padding(.horizontal)
                        .onAppear {
                            authorsVM.onAppear()
                        }
                    if authorsVM.isLoading {
                        SectionLoadingView()
                    } else if let error = authorsVM.error {
                        SectionErrorView(error: error) {
                            authorsVM.refresh()
                        }
                    } else if authorsVM.selection.isEmpty {
                        NoResultsView()
                    } else {
                        AuthorsCarrousel(authors: authorsVM.selection)
                    }
                }
            }
            .navigationTitle(Self.viewTitle)
            .navigationDestinations()
        }
    }
}

#Preview {
    TabView {
        HomeView()
            .tabItem {
                Label(HomeView.viewTitle, systemImage: "house")
            }
    }
    .environment(AuthorsViewModel(repository: .preview))
    .environment(MangasViewModel(repository: .preview))
}
