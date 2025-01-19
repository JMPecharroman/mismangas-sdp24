//
//  LoginView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/1/25.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("UserIsLogged") private var userIsLogged: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var focusedField: LoginField?
    @State var vm: AuthViewModel
    @State private var isLogin = true
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24.0) {
                if userIsLogged {
                    Button(role: .destructive) {
                        vm.logout()
                    } label: {
                        Text("Cerrar sesión")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8.0)
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    VStack(spacing: 8.0) {
                        Text("Email")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("Introduce tu email", text: $vm.email)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .textContentType(.emailAddress)
                            .focused($focusedField, equals: .email)
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = .password
                            }
                        
                        Text("Contraseña")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 8.0)
                        SecureField("Introduce tu contraseña", text: $vm.password)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(isLogin ? .password : .newPassword)
                            .focused($focusedField, equals: .password)
                            .submitLabel(!isLogin ? .next : .done)
                            .onSubmit {
                                focusedField = isLogin ? nil : .passwordConfirmation
                            }
                        
                        if !isLogin {
                            SecureField("Confirma tu contraseña", text: $vm.passwordConfirmation)
                                .textFieldStyle(.roundedBorder)
                                .textContentType(.newPassword)
                                .focused($focusedField, equals: .passwordConfirmation)
                                .submitLabel(.done)
                                .onSubmit {
                                    focusedField = nil
                                }
                        }
                    }
                    if let error = vm.error {
                        Text(error.localizedDescription)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Button {
                        if isLogin {
                            vm.login()
                        } else {
                            vm.register()
                        }
                    } label: {
                        Text(isLogin ? "Iniciar sesión" : "Registrar")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8.0)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(vm.email.isEmpty || vm.password.isEmpty || (!isLogin && vm.passwordConfirmation.isEmpty))
                    
                    Divider()
                        .padding(.vertical)
                    
                    HStack(spacing: 2.0) {
                        Text(isLogin ? "No tengo cuenta, " : "Ya tengo cuenta, ")
                            .foregroundStyle(.secondary)
                        Button {
                            isLogin.toggle()
                        } label: {
                            Text(isLogin ? "quiero registrarme" : "quiero iniciar sesión")
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(isLogin ? "Iniciar sesión" : "Registro")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
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

private enum LoginField {
    case email
    case password
    case passwordConfirmation
}
