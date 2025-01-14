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
    
    var repository: SessionRepository
    
    var email: String = ""
    var password: String = ""
    private(set) var error: Error?
    
    // MARK: Initialization
    
    init(repository: SessionRepository = .api) {
        self.repository = repository
    }
    
    // MARK: Interface
    
    func login() {
        
    }
    
    func register() {
        
    }
}
