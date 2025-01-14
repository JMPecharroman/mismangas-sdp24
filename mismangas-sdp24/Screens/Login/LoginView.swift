//
//  LoginView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/1/25.
//

import SwiftUI

struct LoginView: View {
    
    @State var vm: LoginViewModel
    
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
                Section {
                    VStack {
                        Button {
                            
                        } label: {
                            Text("Iniciar sesión")
                        }
                        ViewThatFits {
                            HStack {
                                Text("Ya tengo cuenta,")
                                Button {
                                    
                                } label: {
                                    Text("quiero iniciar sesión")
                                }
                            }
                            VStack {
                                Text("Ya tengo cuenta,")
                                Button {
                                    
                                } label: {
                                    Text("quiero iniciar sesión")
                                }
                            }
                        }
                        .padding(.top, 24.0)
                    }
                    .frame(maxWidth: .infinity)
                } header: {
                    Text("")
                }
            }
            .navigationTitle("Iniciar sesión")
            .navigationBarTitleDisplayMode(.inline)
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

