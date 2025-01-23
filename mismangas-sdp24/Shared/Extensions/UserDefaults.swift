//
//  UserDefaults.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 23/1/25.
//

import Foundation

@MainActor
extension UserDefaults {
    func date(forKey userDefaultsKey: UserDefaultsKey) -> Date? {
        object(forKey: userDefaultsKey.rawValue) as? Date
    }
    
    func bool(forKey userDefaultsKey: UserDefaultsKey) -> Bool {
        bool(forKey: userDefaultsKey.rawValue)
    }
    
    func removeObject(forKey userDefaultsKey: UserDefaultsKey) {
        removeObject(forKey: userDefaultsKey.rawValue)
    }
    
    func set(_ value: Bool, forKey userDefaultsKey: UserDefaultsKey) {
        set(value, forKey: userDefaultsKey.rawValue)
    }
    func set(_ value: Date, forKey userDefaultsKey: UserDefaultsKey) {
        set(value, forKey: userDefaultsKey.rawValue)
    }
}
