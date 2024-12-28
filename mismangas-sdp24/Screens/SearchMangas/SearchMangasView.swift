//
//  SearchMangasView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 22/12/24.
//

import SwiftUI

struct SearchMangasView: View {
    
    static let viewTitle: String = "Buscar"
    
    @Environment(MangasViewModel.self) private var mangasVM
    @State var searchVM: SearchViewModel = .init()
    
    @State private var isLoading: Bool = true
    @State private var showFilterSheet: Bool = false
    @State private var showSearchOptions: Bool = false
    @State private var showSearchResults: Bool = false
    @State private var searchableIsPresented: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            if searchText.isEmpty {
                MangasList(vm: mangasVM)
                    .navigationTitle(Self.viewTitle)
            } else {
                List {
                    if showSearchOptions {
                        Section {
                            Button {
                                performSearch(searchCase: .author)
                            } label: {
                                Label("Autores con \"\(searchText)\"", systemImage: "magnifyingglass")
                            }
                            Button {
                                performSearch(searchCase: .mangaContains)
                            } label: {
                                Label("Mangas con \"\(searchText)\"", systemImage: "magnifyingglass")
                            }
                            Button {
                                performSearch(searchCase: .mangaBegins)
                            } label: {
                                Label("Mangas que empiezan con \"\(searchText)\"", systemImage: "magnifyingglass")
                            }
                        } header: {
                            Text("Buscar")
                        }
                    }
                    if showSearchResults {
                        Section {
                            if searchVM.useMangasList {
                                MangasListContent(vm: searchVM)
                            } else {
                                AuthorsListContent(vm: searchVM)
                            }
                        } header: {
                            Text(searchVM.sectionLabel)
                        }
                    }
                }
            }
        }
//        .searchable(text: $searchText, isPresented: $searchableIsPresented)
        .debouncedSearchable(text: $searchText, isPresented: $searchableIsPresented, delay: .seconds(2.0)) { _ in
            guard !showSearchResults else { return }
            performSearch(searchCase: nil)
        }
        .onChange(of: searchText) {
            showSearchOptions = true
            showSearchResults = false
        }
        .onChange(of: searchableIsPresented) {
            if searchableIsPresented {
                showSearchOptions = true
            }
            print("searchableIsPresented: \(searchableIsPresented)")
        }
        .sheet(isPresented: $showFilterSheet) {
            SearchFiltersView()
        }
        .onSubmit(of: .search) {
            performSearch(searchCase: nil)
        }
    }
    
    private func performSearch(searchCase: SearchCase?) {
        showSearchOptions = false
        showSearchResults = true
        searchableIsPresented = false
        searchVM.search(searchText, searchCase: searchCase)
    }
}

#Preview {
    SearchMangasView(searchVM: SearchViewModel(repository: .preview))
        .environment(MangasViewModel(repository: .preview))
}
