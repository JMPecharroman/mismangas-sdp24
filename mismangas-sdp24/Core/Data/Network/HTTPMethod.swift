//
//  HTTPMethod.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Métodos HTTP disponibles para realizar solicitudes de red.
enum HTTPMethod: String {
    
    /// Método HTTP GET para obtener datos del servidor.
    case get = "GET"
    
    /// Método HTTP POST para enviar datos al servidor.
    case post = "POST"
    
    /// Método HTTP PUT para actualizar recursos en el servidor.
    case put = "PUT"
    
    /// Método HTTP DELETE para eliminar recursos en el servidor.
    case delete = "DELETE"
}
