//
//  AuthViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/1/25.
//

import Foundation
import SwiftUI

/// Modelo de vista para la autenticación de usuarios.
@Observable @MainActor
final class AuthViewModel {
    
    /// Repositorio de autenticación para gestionar las llamadas a la API.
    private var repository: AuthRepository
    
    /// Correo electrónico ingresado por el usuario.
    var email: String = ""
    
    /// Contraseña ingresada por el usuario.
    var password: String = ""
    
    /// Confirmación de la contraseña ingresada por el usuario (solo en registro).
    var passwordConfirmation: String = ""
    
    /// Indica si hay una operación en curso.
    private(set) var isLoading: Bool = false
    
    /// Error generado en la última operación.
    private(set) var error: Error?
    
    /// Indica si la última solicitud se completó con éxito.
    var requestSuccessful: Bool = false
    
    // MARK: Initialization
    
    /// Crea una nueva instancia del `AuthViewModel`.
    ///
    /// - Parameter repository: Repositorio de autenticación a utilizar. Por defecto, usa la API.
    init(repository: AuthRepository = .api) {
        self.repository = repository
        
#if DEBUG
        email = "prueba@prueba.es"
        password = "12345678"
        passwordConfirmation = "12345678"
#endif
    }
    
    // MARK: Interface
    
    /// Inicia sesión con el correo y la contraseña ingresados.
    func login() {
        guard !isLoading else { return }
        
        do {
            try validateForm()
        } catch {
            self.error = error
            return
        }
        
        isLoading = true
        error = nil
        
        Task {
            await loginAPI(email: email, password: password)
        }
    }
    
    /// Cierra la sesión del usuario actual.
    func logout() {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await logoutAPI()
        }
    }
    
    /// Registra un nuevo usuario con el correo y la contraseña ingresados.
    func register() {
        guard !isLoading else { return }
        
        do {
            try validateForm(isRegister: true)
        } catch {
            self.error = error
            return
        }
        
        isLoading = true
        error = nil
        
        Task {
            await registerAPI(email: email, password: password)
        }
    }
    
    // MARK: Internal
    
    /// Iniciar sesión con las credenciales proporcionadas.
    ///
    /// - Parameters:
    ///   - email: Correo electrónico del usuario.
    ///   - password: Contraseña del usuario.
    @RepositoryActor
    private func loginAPI(email: String, password: String) async {
        do {
            let token = try await repository.login(email: email, password: password)
            print("Token: \(token)")
            await repository.logged(withToken: token)
            await MainActor.run {
                requestSuccessful = true
                isLoading = false
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            await MainActor.run {
                self.error = error
                isLoading = false
            }
        }
    }
    
    /// Cerrar sesión.
    @RepositoryActor
    private func logoutAPI() async {
        await repository.logout()
        
        await MainActor.run {
            isLoading = false
        }
    }
    
    /// Registrar un nuevo usuario.
    ///
    /// - Parameters:
    ///   - email: Correo electrónico del nuevo usuario.
    ///   - password: Contraseña del nuevo usuario.
    @RepositoryActor
    private func registerAPI(email: String, password: String) async {
        do {
            try await repository.register(email: email, password: password)
            
            await MainActor.run {
                requestSuccessful = true
                isLoading = false
            }
        } catch {
            print("Error: \(error)")
            await MainActor.run {
                self.error = error
                isLoading = false
            }
        }
    }
    
    /// Valida los datos del formulario antes de iniciar sesión o registrarse.
    ///
    /// - Parameter isRegister: Indica si la validación es para un registro de usuario.
    /// - Throws: `AuthError` si los datos ingresados no son válidos.
    private func validateForm(isRegister: Bool = false) throws {
        if email.isEmpty { throw AuthError.emailIsEmpty }
        if !email.isValidEmail { throw AuthError.emailNotValid }
        if password.isEmpty { throw AuthError.passwordIsEmpty }
        if password.count < 8 { throw AuthError.passwordIsTooShort(8) }
        if password.count > 16 { throw AuthError.passwordIsTooLong(16) }
        
        guard isRegister else { return }
        
        if passwordConfirmation.isEmpty { throw AuthError.passwordConfirmationIsEmpty }
        if password != passwordConfirmation { throw AuthError.passwordsDoNotMatch }
    }
}
