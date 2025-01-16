//
//  LoginView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/1/25.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var vm: LoginViewModel
    
    @State private var isLogin = true
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Introduce tu email", text: $vm.email)
                } header: {
                    Text("Email")
                }
                Section {
                    TextField("Introduce tu contraseña", text: $vm.password)
                } header: {
                    Text("Contraseña")
                }
                if !isLogin {
                    Section {
                        TextField("Introduce tu contraseña", text: $vm.password)
                    } header: {
                        Text("Confirma tu contraseña")
                    }
                }
                Section {
                    Button {
                        if isLogin {
                            vm.login()
                        } else {
                            vm.register()
                        }
                    } label: {
                        Text(isLogin ? "Iniciar sesión" : "Registarme")
                    }
                }
                Section {
                    Button {
                        isLogin.toggle()
                    } label: {
                        Text(isLogin ? "Registrarme" : "Iniciar sesión")
                            .font(.callout)
                    }
                }
                header: {
                    Text(isLogin ? "No tengo cuenta" : "Ya tengo cuenta")
                }
            }
            .navigationTitle("Iniciar sesión")
            .navigationBarTitleDisplayMode(.inline)
            .animation(.default, value: isLogin)
            .loading(vm.isLoading)
            .alert(isLogin ? "Sesión iniciada correctamente" : "Registro completado correctamente", isPresented: $vm.requestSuccessful) {
                Button {
                    dismiss()
                } label: {
                    Text("Aceptar")
                }
            }
        }
    }
}

extension LoginView {
    init() {
        self.init(vm: LoginViewModel())
    }
}

#Preview {
    LoginView(vm: .preview)
}

