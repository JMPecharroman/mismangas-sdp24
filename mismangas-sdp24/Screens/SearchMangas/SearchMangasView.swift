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
    @State var searchVM: SearchViewModel
    
    @State private var isLoading: Bool = true
    @State private var showFilterSheet: Bool = false
    @State private var showSearchOptions: Bool = false
    @State private var showSearchResults: Bool = false
    @State private var searchableIsPresented: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                if searchText.isEmpty {
                    MangasList(vm: searchVM.isCustomSearch ? searchVM : mangasVM)
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
                                    Label("Mangas que comienzan con \"\(searchText)\"", systemImage: "magnifyingglass")
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
                                    AuthorsListContent(vm: $searchVM)
                                }
                            } header: {
                                Text(searchVM.sectionLabel)
                            }
                        }
                    }
                }
            }
            .navigationDestinations()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFilterSheet = true
                    } label: {
                        Label("Búsqueda avanzada", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .debouncedSearchable(text: $searchText, isPresented: $searchableIsPresented, delay: .seconds(2.0)) { _ in
                guard !showSearchResults else { return }
                performSearch(showSearchOptions: true, searchCase: nil)
            }
        }
        .onChange(of: searchText) {
            showSearchOptions = true
            showSearchResults = false
        }
        .onChange(of: searchableIsPresented) {
            guard searchableIsPresented else { return }
            showSearchOptions = true
        }
        .sheet(isPresented: $showFilterSheet) {
            SearchFiltersView(vm: $searchVM, isPresented: $showFilterSheet)
        }
        .onSubmit(of: .search) {
            performSearch(searchCase: nil)
        }
    }
    
    private func performSearch(showSearchOptions: Bool = false, searchCase: SearchCase?) {
        self.showSearchOptions = showSearchOptions
        showSearchResults = true
        searchableIsPresented = false
        searchVM.search(searchText, searchCase: searchCase)
    }
}

extension SearchMangasView {
    init () {
        self.init(searchVM: SearchViewModel())
    }
}

#Preview {
    SearchMangasView(searchVM: SearchViewModel(repository: .preview))
        .environment(MangasViewModel(repository: .preview))
}
