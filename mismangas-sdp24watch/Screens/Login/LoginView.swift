//
//  LoginView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 25/1/25.
//

import SwiftUI

struct LoginView: View {
    
    @State var vm: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Email", text: $vm.email)
                    .textContentType(.emailAddress)
                TextField("Contraseña", text: $vm.password)
                    .textContentType(.password)
                Button {
                    vm.login()
                } label: {
                    Text("Iniciar sesión")
                }
                if let error = vm.error {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                }
            }
            .loading(vm.isLoading)
        }
    }
}

extension LoginView {
    init() {
        self.init(vm: AuthViewModel())
    }
}

#Preview {
    LoginView(vm: .preview)
}
