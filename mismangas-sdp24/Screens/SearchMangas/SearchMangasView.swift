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
                        Button {
                            showSearchOptions = false
                            searchableIsPresented = false
                            searchVM.search(searchText)
                        } label: {
                            Text("Buscar \(searchText)")
                        }
                    } else {
                        MangasListContent(vm: searchVM)
                    }
                }
            }
        }
        .searchable(text: $searchText, isPresented: $searchableIsPresented)
//        .debouncedSearchable(text: $searchText) {
//            searchVM.search($0)
//        }
        .onChange(of: searchText) {
            showSearchOptions = true
        }
        .sheet(isPresented: $showFilterSheet) {
            SearchFiltersView()
        }
    }
}

#Preview {
    SearchMangasView(searchVM: SearchViewModel(repository: .preview))
        .environment(MangasViewModel(repository: .preview))
}
