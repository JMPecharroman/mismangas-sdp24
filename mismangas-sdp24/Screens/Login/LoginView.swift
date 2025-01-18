//
//  LoginView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/1/25.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("UserIsLogged") private var userIsLogged: Bool = false
    
    @State var vm: AuthViewModel
    
    @State private var isLogin = true
    
    var body: some View {
        NavigationStack {
            Form {
                if userIsLogged {
                    Button(role: .destructive) {
                        
                    } label: {
                        Text("Cerrar sesión")
                    }
                } else {
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
                            TextField("Introduce tu contraseña", text: $vm.passwordConfirmation)
                        } header: {
                            Text("Confirma tu contraseña")
                        }
                    }
                    
                    if let error = vm.error {
                        Section {
                            Text(error.localizedDescription)
                                .foregroundStyle(.red)
                        } header: {
                            Text("Error")
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
                            Text(isLogin ? "Quiero registrarme" : "Quiero iniciar sesión")
                                .font(.callout)
                        }
                    } header: {
                        Text(isLogin ? "No tengo cuenta" : "Ya tengo cuenta")
                    }
                }
            }
            .navigationTitle(isLogin ? "Iniciar sesión" : "Registro")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                    }
                }
            }
            .animation(.default, value: isLogin)
            .loading(vm.isLoading)
            .alert(isLogin ? "Inicio de sesión" : "Registro", isPresented: $vm.requestSuccessful) {
                Button {
                    if isLogin {
                        dismiss()
                    } else {
                        isLogin.toggle()
                        vm.passwordConfirmation = ""
                    }
                } label: {
                    Text("Aceptar")
                }
            } message: {
                Text(isLogin ? "Has iniciado sesión correctamente" : "Te has registrado correctamente. Ya puedes inicar sesiñón con tu cuenta.")
            }
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

