//
//  URLQueryItem.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Extensión para facilitar la creación de parámetros de consulta en URL.
extension URLQueryItem {
    
    /// Crea un parámetro de consulta para la paginación en las solicitudes de red.
    ///
    /// - Parameter page: Número de página a solicitar.
    /// - Returns: Un `URLQueryItem` configurado con el número de página.
    static func page(_ page: Int) -> URLQueryItem {
        URLQueryItem(name: "page", value: "\(page)")
    }
}
