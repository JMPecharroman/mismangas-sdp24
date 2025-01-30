//
//  ContentView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 3/12/24.
//

/// La vista principal de la aplicación "Mis Mangas".
///
/// Esta vista gestiona la navegación mediante un `TabView` y muestra diferentes secciones de la aplicación,
/// como la pantalla de inicio, la colección de mangas y la búsqueda de mangas.
/// También maneja el estado de autenticación del usuario y sincronización de datos.
import SwiftUI

struct ContentView: View {
    
    /// Indica si el usuario ha iniciado sesión, almacenado en `UserDefaults`.
    @AppStorage(UserDefaultsKey.userIsLogged.rawValue) private var userIsLogged: Bool = false
    
    /// Contexto del modelo de datos utilizado para gestionar la sincronización.
    @Environment(\.modelContext) private var modelContext
    
    /// ViewModel encargado de gestionar la sincronización de datos en la aplicación con la api.
    @Environment(SyncViewModel.self) private var vm
    
    /// Estado que controla la visibilidad de la alerta de inicio de sesión.
    @State private var showLoggedAlert: Bool = false
    
    /// Estado que controla la presentación de la vista de inicio de sesión.
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
            /// Llama al método `onAppear` del `SyncViewModel` para gestionar la sincronización de datos.
            vm.onAppear(modelContext: modelContext)
        }
        .onChange(of: vm.needRelogin) {
            /// Si la sesión del usuario ha expirado, se muestra la pantalla de inicio de sesión.
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
            /// Si el usuario inicia sesión correctamente, se muestra una alerta de confirmación.
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
