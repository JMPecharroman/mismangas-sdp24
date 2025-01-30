//
//  URLRequest.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Extensión de `URLRequest` para simplificar la creación de solicitudes HTTP.
extension URLRequest {
    
    /// Crea una solicitud HTTP basada en un `EndPoint`.
    /// - Parameter endPoint: El `EndPoint` que define la solicitud.
    /// - Returns: Una instancia de `URLRequest` configurada con el método, encabezados y cuerpo de la solicitud.
    static func createRequest(from endPoint: EndPoint) -> URLRequest {
        var request = URLRequest(url: endPoint.url)
        request.timeoutInterval = 60
        request.httpMethod = endPoint.method.rawValue
        
        endPoint.headers.forEach { header in
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if let body = endPoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
            
        return request
    }
    
    /// Genera una solicitud HTTP `GET` para un `EndPoint`.
    /// - Parameter endPoint: El `EndPoint` que define la URL.
    /// - Returns: Una solicitud `URLRequest` configurada con el método `GET`.
    static func get(_ endPoint: EndPoint) -> URLRequest {
        var request = URLRequest(url: endPoint.url)
        request.timeoutInterval = 60
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    /// Genera una solicitud HTTP `GET` para una URL específica.
    /// - Parameter url: La URL de la solicitud.
    /// - Returns: Una solicitud `URLRequest` configurada con el método `GET`.
    static func get(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("Bearer LKJASLKJASLKJD", forHTTPHeaderField: "Authorization")
        return request
    }
    
    /// Genera una solicitud HTTP con un cuerpo codificable.
    /// - Parameters:
    ///   - url: La URL de la solicitud.
    ///   - body: El cuerpo de la solicitud en formato JSON.
    ///   - method: El método HTTP a utilizar (por defecto `POST`).
    /// - Returns: Una solicitud `URLRequest` configurada con el método, encabezados y cuerpo de la solicitud.
    static func post<JSON>(url: URL, body: JSON, method: HTTPMethod = .post) -> URLRequest where JSON: Encodable {
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        return request
    }
}
