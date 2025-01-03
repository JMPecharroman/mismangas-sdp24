//
//  ContentView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 3/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(HomeView.viewTitle, systemImage: "house")
                }
            CollectionView()
                .tabItem {
                    Label(CollectionView.viewTitle, systemImage: "books.vertical")
                }
            SearchMangasView()
                .tabItem {
                    Label(SearchMangasView.viewTitle, systemImage: "magnifyingglass")
                }
        }
    }
}


#Preview {
    ContentView()
        .environment(AuthorsViewModel(repository: .preview))
        .environment(CategoriesViewModel(repository: .preview))
        .environment(MangasViewModel(repository: .preview))
}
