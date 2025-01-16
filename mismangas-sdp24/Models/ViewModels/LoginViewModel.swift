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
    private(set) var isLoading: Bool = false
    private(set) var error: Error?
    var requestSuccessful: Bool = false
    
    // MARK: Initialization
    
    init(repository: SessionRepository = .api) {
        self.repository = repository
    }
    
    // MARK: Interface
    
    func login() {
        
    }
    
    func register() {
        guard !isLoading else { return }
        
        isLoading = true
        
        Task {
            await registerAPI(email: email, password: password)
        }
    }
    
    // MARK: Internal
    
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
}
