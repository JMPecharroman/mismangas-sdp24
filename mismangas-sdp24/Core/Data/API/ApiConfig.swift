//
//  ApiConfig.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/1/25.
//

import Foundation

struct ApiConfig {
    
    static let appToken: String = getfromPlist("AppToken")
    
    private init() {}
    
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
