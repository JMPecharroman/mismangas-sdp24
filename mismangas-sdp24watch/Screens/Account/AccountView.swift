//
//  AccountView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import SwiftUI

struct AccountView: View {
    
    static let viewTitle: String = "Cuenta"
    
    @State var vm: AuthViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.seal")
                .resizable()
                .foregroundStyle(.green)
                .frame(width: 56.0, height: 56.0)
            Text("Tienes una sesión activa")
            Spacer()
            Button(role: .destructive) {
                vm.logout()
            } label: {
                Text("Cerrar sesión")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8.0)
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .navigationTitle(Self.viewTitle)
        .navigationBarTitleDisplayMode(.inline)
        .loading(vm.isLoading)
    }
}

extension AccountView {
    init() {
        self.init(vm: AuthViewModel())
    }
}

#Preview {
    AccountView(vm: .preview)
}
