//
//  SearchFiltersView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 22/12/24.
//

import SwiftUI

struct SearchFiltersView: View {
    
    @Environment(CategoriesViewModel.self) private var categoriesVM
    @Binding var vm: SearchViewModel
    
    @Binding var isPresented: Bool
    
    @State private var title: String = ""
    @State private var authorFirstName: String = ""
    @State private var authorLastName: String = ""
    @State private var genres: [String] = []
    @State private var themes: [String] = []
    @State private var demographics: [String] = []
    @State private var contains: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Título")) {
                    TextField("Filtrar por título", text: $title)
                }
                
                Section(header: Text("Autor")) {
                    TextField("Filtrar por nombre", text: $authorFirstName)
                    TextField("Filtrar por apellido", text: $authorLastName)
                }
                
                SearchCategorySection(
                    categoryGroup: .genre,
                    categories: categoriesVM.itemsSelection(for: .genre),
                    selectedItems: $genres
                )
                
                SearchCategorySection(
                    categoryGroup: .theme,
                    categories: categoriesVM.itemsSelection(for: .theme),
                    selectedItems: $themes
                )
                
                SearchCategorySection(
                    categoryGroup: .demographic,
                    categories: categoriesVM.items(for: .demographic),
                    selectedItems: $demographics
                )
                
                Section {
                    Toggle(contains ? "Contiene" : "Empieza por", isOn: $contains)
                } header: {
                    Text("Modo de filtrado")
                }
            }
            .navigationTitle("Búsqueda avanzada")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: Verificar que hay algo para filtrar
                        print("Pressed")
                        isPresented = false
                        vm.search(filter)
                    } label: {
                        Text("Buscar")
                    }
                }
            }
        }
    }
    
    private var filter: CustomSearch {
        CustomSearch(
            searchTitle: title.nullifyIfEmpty,
            searchAuthorFirstName: authorFirstName.nullifyIfEmpty,
            searchAuthorLastName: authorLastName.nullifyIfEmpty,
            searchGenres: genres.nullifyIfEmpty,
            searchThemes: themes.nullifyIfEmpty,
            searchDemographics: demographics.nullifyIfEmpty,
            searchContains: contains
        )
    }
}

#Preview {
    SearchMangasView(searchVM: SearchViewModel(repository: .preview))
        .environment(MangasViewModel(repository: .preview))
}
