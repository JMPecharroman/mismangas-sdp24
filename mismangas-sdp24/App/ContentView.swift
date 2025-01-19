//
//  ContentView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 3/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(SyncViewModel.self) private var vm
    
    @State private var showLoginView: Bool = false
    
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
        .sheet(isPresented: $showLoginView) {
            LoginView()
        }
        .loading(vm.isSynchronizing, opacity: 1.0)
        .onAppear {
            vm.onAppear(modelContext: modelContext)
        }
        .onChange(of: vm.needRelogin) {
            if vm.needRelogin {
                showLoginView = true
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthorsViewModel(repository: .preview))
        .environment(CategoriesViewModel(repository: .preview))
        .environment(MangasViewModel(repository: .preview))
        .environment(SyncViewModel(repository: .preview, repositoryNetwork: .preview))
}
