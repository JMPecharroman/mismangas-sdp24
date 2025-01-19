//
//  AuthManager.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/1/25.
//

import Foundation

protocol AuthManager {
    
}

@MainActor
extension AuthManager {
    func logged(withToken token: String) async {
        await Keychain.shared.setString(token, forKey: .token)
        UserDefaults.standard.set(true, forKey: "UserIsLogged") // TODO: No dejar como string
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: .sessionDidChange, object: nil)
    }
    
    func logout() async {
        print("Logout")
        await Keychain.shared.removeObject(forKey: .token)
        UserDefaults.standard.removeObject(forKey: "UserIsLogged") // TODO: No dejar como string
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: .sessionDidChange, object: nil)
    }
    
    var userToken: String? {
        get async {
            await Keychain.shared.string(forKey: .token)
        }
    }
    
    var userIsLogged: Bool {
        UserDefaults.standard.bool(forKey: "UserIsLogged") // TODO: No dejar como string
    }
}
