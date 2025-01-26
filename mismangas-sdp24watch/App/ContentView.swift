//
//  ContentView.swift
//  mismangas-sdp24watch
//
//  Created by José Mª Pecharromán on 25/1/25.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage(UserDefaultsKey.userIsLogged.rawValue) private var userIsLoggeed: Bool = false
    
    @Environment(\.modelContext) private var modelContext
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
