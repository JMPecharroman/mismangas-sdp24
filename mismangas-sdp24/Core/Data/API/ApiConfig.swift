//
//  ApiConfig.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/1/25.
//

import Foundation

/// `ApiConfig` gestiona la configuración segura de la API, incluyendo la recuperación del token de autenticación.
///
/// # Seguridad:
/// El **App Token** se almacena en un archivo privado `ApiConfig.plist`, que **no debe subirse al repositorio**.
/// Para evitar exponer credenciales en GitHub, este archivo se debe agregar a `.gitignore`.
///
/// # Configuración:
/// 1. **Crear el archivo `ApiConfig.plist`** dentro del proyecto.
/// 2. **Agregar la clave necesaria** en el plist:
/// ```xml
/// <dict>
///     <key>AppToken</key>
///     <string>MI_APP_TOKEN_SECRETO</string>
/// </dict>
/// ```
/// 3. **Añadir `ApiConfig.plist` al `.gitignore`**:
/// ```gitignore
/// ApiConfig.plist
/// ```
/// 4. **Asegurarse de que el archivo esté en el Bundle de la app**.
///
/// # Uso:
/// ```swift
/// let token = ApiConfig.appToken
/// ```
///
/// Este token se obtiene automáticamente y se usa para autenticarse en las solicitudes HTTP a la API del proyecto.
enum ApiConfig {
    
    /// `appToken` contiene el valor del token de autenticación extraído del archivo **ApiConfig.plist**.
    static let appToken: String = getfromPlist("AppToken")
    
    /// Obtiene el valor asociado a una clave dentro del archivo **ApiConfig.plist**.
    ///
    /// Este método busca dentro del archivo **Property List (plist)** en el `Bundle.main`, decodifica su contenido y extrae el valor correspondiente a la clave proporcionada.
    ///
    /// - Parameter key: Clave que se quiere buscar dentro del plist.
    /// - Returns: El valor asociado a la clave especificada.
    /// - Throws: Genera un error fatal si el archivo **ApiConfig.plist** no está presente, si hay un fallo en la decodificación del plist o si la clave no existe.
    ///
    /// # Ejemplo de uso:
    /// ```swift
    /// let appToken = ApiConfig.getfromPlist("AppToken")
    /// ```
    private static func getfromPlist(_ key: String) -> String {
        guard let url = Bundle.main.url(forResource: "ApiConfig", withExtension: ".plist") else {
            fatalError("No se ha encontrado el fichero ApiConfig.plist en el Bundle")
        }
        
        let plist: [String : String]
        
        do {
            let data = try Data(contentsOf: url)
            plist = try PropertyListDecoder().decode([String:String].self, from: data)
        } catch {
            fatalError("Se ha producido el error \(error.localizedDescription) al leer el fichero ApiConfig.plist")
        }
        
        guard let token = plist[key] else {
            fatalError("No se ha encontrado \(key) en el fichero ApiConfig.plist")
        }
        
        return token
    }
}
