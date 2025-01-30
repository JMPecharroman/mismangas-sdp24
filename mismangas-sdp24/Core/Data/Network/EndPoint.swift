//
//  EndPoint.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 19/1/25.
//

import Foundation

/// Protocolo que define los requisitos para construir un endpoint en la API.
protocol EndPoint {
    
    /// URL del endpoint al que se realizará la petición.
    var url: URL { get }
    
    /// Cuerpo de la petición en caso de ser necesario.
    var body: Encodable? { get }
    
    /// Encabezados HTTP requeridos para la solicitud.
    var headers: [HeaderField] { get }
    
    /// Método HTTP que se utilizará en la petición.
    var method: HTTPMethod { get }
}
