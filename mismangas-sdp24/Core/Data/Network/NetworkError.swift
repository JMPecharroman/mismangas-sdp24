//
//  NetworkError.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Posibles errores en la gestión de red.
enum NetworkError: LocalizedError {
    
    /// Error general con la descripción del problema.
    case general(Error)
    
    /// Código de estado HTTP no esperado.
    case status(Int)
    
    /// Error al decodificar JSON.
    case json(Error)
    
    /// Datos no válidos en la respuesta.
    case dataNotValid
    
    /// La respuesta no es una conexión HTTP.
    case nonHTTP
    
    /// Descripción del error en texto legible.
    var errorDescription: String? {
        switch self {
            case .general(let error):
                "Error general: \(error.localizedDescription)."
            case .status(let int):
                "Error de status: \(int)."
            case .json(let error):
                "Error JSON: \(error)"
            case .dataNotValid:
                "Error, dato no válido."
            case .nonHTTP:
                "No es una conexión HTTP."
        }
    }
}
