//
//  ContentView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 3/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State var vm: SyncViewModel
    
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
        .sheet(isPresented: $vm.needRelogin) {
            LoginView()
        }
        .loading(vm.isSynchronizing, opacity: 1.0)
        .onAppear {
            vm.onAppear(modelContext: modelContext)
        }
    }
}

extension ContentView {
    init() {
        self.init(vm: SyncViewModel(repository: nil, repositoryNetwork: .api))
    }
}

#Preview {
    // TODO: Completar esto
//    ContentView(vm: .init(repository: nil, repositoryNetwork: .preview))
    ContentView()
        .environment(AuthorsViewModel(repository: .preview))
        .environment(CategoriesViewModel(repository: .preview))
        .environment(MangasViewModel(repository: .preview))
}
