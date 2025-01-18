//
//  AuthManager.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/1/25.
//

import Foundation

protocol AuthManager {
    
}

extension AuthManager {
    func logged(withToken token: String) async {
        await Keychain.shared.setString(token, forKey: .token)
        UserDefaults.standard.set(true, forKey: "UserIsLogged") // TODO: No dejar como string
        UserDefaults.standard.synchronize()
    }
    
    var userIsLogged: Bool {
        UserDefaults.standard.bool(forKey: "UserIsLogged") // TODO: No dejar como string
    }
}
