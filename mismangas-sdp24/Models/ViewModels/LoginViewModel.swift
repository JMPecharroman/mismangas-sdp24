//
//  LoginViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/1/25.
//

import Foundation
import SwiftUI

@Observable @MainActor
final class LoginViewModel {
    
    private var repository: SessionRepository
    
    var email: String = ""
    var password: String = ""
    var passwordConfirmation: String = ""
    private(set) var isLoading: Bool = false
    private(set) var error: Error?
    var requestSuccessful: Bool = false
    
    // MARK: Initialization
    
    init(repository: SessionRepository = .api) {
        self.repository = repository
        
#if DEBUG
        email = "prueba@prueba.es"
        password = "12345678"
        passwordConfirmation = "12345678"
#endif
    }
    
    // MARK: Interface
    
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
    
    @RepositoryActor
    private func loginAPI(email: String, password: String) async {
        do {
            let token = try await repository.login(email: email, password: password)
            
            print("Token: \(token)")
            
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
    
    @RepositoryActor
    private func registerAPI(email: String, password: String) async {
        do {
            try await repository.register(email: email, password: password)
            
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
    
    private func validateForm(isRegister: Bool = false) throws {
        if email.isEmpty { throw SessionError.emailIsEmpty }
        if password.isEmpty { throw SessionError.passwordIsEmpty }
        
        guard isRegister else { return }
        
        if passwordConfirmation.isEmpty { throw SessionError.passwordConfirmationIsEmpty }
        if password != passwordConfirmation { throw SessionError.passwordsDoNotMatch }
    }
}
