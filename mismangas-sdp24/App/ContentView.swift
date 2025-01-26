//
//  ContentView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 3/12/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(UserDefaultsKey.userIsLogged.rawValue) private var userIsLogged: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    @Environment(SyncViewModel.self) private var vm
    
    @State private var showLoggedAlert: Bool = false
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
        .loading(vm.isSynchronizing, label: "Sincronizando...", opacity: 1.0)
        .onAppear {
            vm.onAppear(modelContext: modelContext)
        }
        .onChange(of: vm.needRelogin) {
            if vm.needRelogin {
                showLoginView = true
            }
        }
        .alert("Inicio de sesión", isPresented: $showLoggedAlert) {
            Button {
                showLoggedAlert = false
            } label: {
                Text("Aceptar")
            }
        } message: {
            Text("Has iniciado sesión correctamente")
        }
        .onChange(of: userIsLogged) {
            if userIsLogged {
                showLoggedAlert = true
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
