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
    
    var lastTokenRenew: Date? {
        UserDefaults.standard.date(forKey: .lastTokenRenew)
    }
    
    func logged(withToken token: String) async {
        await tokenRenewed(token)
        NotificationCenter.default.post(name: .sessionDidChange, object: nil)
    }
    
    func logout() async {
        await Keychain.shared.removeObject(forKey: .token)
        UserDefaults.standard.set(false, forKey: .userIsLogged)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: .sessionDidChange, object: nil)
    }
    
    func tokenRenewed(_ token: String) async {
        await Keychain.shared.setString(token, forKey: .token)
        UserDefaults.standard.set(true, forKey: .userIsLogged)
        UserDefaults.standard.set(Date(), forKey: .lastTokenRenew)
        UserDefaults.standard.synchronize()
    }
    
    var userToken: String? {
        get async {
            await Keychain.shared.string(forKey: .token)
        }
    }
    
    var userIsLogged: Bool {
        UserDefaults.standard.bool(forKey: .userIsLogged)
    }
}
