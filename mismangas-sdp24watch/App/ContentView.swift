//
//  ContentView.swift
//  mismangas-sdp24watch
//
//  Created by José Mª Pecharromán on 25/1/25.
//

import SwiftUI

/// Vista principal de la aplicación que gestiona la navegación entre la pantalla de inicio y el login.
struct ContentView: View {
    
    /// Estado que indica si el usuario ha iniciado sesión.
    @AppStorage(UserDefaultsKey.userIsLogged.rawValue) private var userIsLoggeed: Bool = false
    
    /// Contexto del modelo para la gestión de datos con SwiftData.
    @Environment(\.modelContext) private var modelContext
    
    /// ViewModel encargado de la sincronización de datos.
    @Environment(SyncViewModel.self) private var vm
    
    var body: some View {
        VStack {
            if userIsLoggeed {
                HomeView()
            } else  {
                LoginView()
            }
        }
        .loading(vm.isSynchronizing, label: "Sincronizando...", opacity: 1.0)
        .onAppear {
            vm.onAppear(modelContext: modelContext)
        }
    }
}

#Preview {
    ContentView()
}
