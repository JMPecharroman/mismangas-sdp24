//
//  UserDefaults.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 23/1/25.
//

import Foundation

/// Extensión de `UserDefaults` para facilitar el acceso a valores con claves tipadas.
@MainActor
extension UserDefaults {
    
    /// Recupera una fecha almacenada en `UserDefaults`.
    /// - Parameter userDefaultsKey: Clave con la que se ha guardado la fecha.
    /// - Returns: Valor de tipo `Date` si existe, `nil` en caso contrario.
    func date(forKey userDefaultsKey: UserDefaultsKey) -> Date? {
        object(forKey: userDefaultsKey.rawValue) as? Date
    }
    
    /// Recupera un valor booleano almacenado en `UserDefaults`.
    /// - Parameter userDefaultsKey: Clave con la que se ha guardado el valor.
    /// - Returns: `true` o `false` dependiendo del valor almacenado.
    func bool(forKey userDefaultsKey: UserDefaultsKey) -> Bool {
        bool(forKey: userDefaultsKey.rawValue)
    }
    
    /// Elimina un objeto almacenado en `UserDefaults` para una clave específica.
    /// - Parameter userDefaultsKey: Clave del objeto a eliminar.
    func removeObject(forKey userDefaultsKey: UserDefaultsKey) {
        removeObject(forKey: userDefaultsKey.rawValue)
    }
    
    /// Guarda un valor booleano en `UserDefaults`.
    /// - Parameters:
    ///   - value: Valor booleano a guardar.
    ///   - userDefaultsKey: Clave bajo la cual se almacenará el valor.
    func set(_ value: Bool, forKey userDefaultsKey: UserDefaultsKey) {
        set(value, forKey: userDefaultsKey.rawValue)
    }
    
    /// Guarda una fecha en `UserDefaults`.
    /// - Parameters:
    ///   - value: Fecha a guardar.
    ///   - userDefaultsKey: Clave bajo la cual se almacenará la fecha.
    func set(_ value: Date, forKey userDefaultsKey: UserDefaultsKey) {
        set(value, forKey: userDefaultsKey.rawValue)
    }
}
