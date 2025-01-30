//
//  Network.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import Foundation

/// Interacción con la red para gestionar las peticiones HTTP.
struct Network: NetworkInteractor {
    
    /// Sesión compartida utilizada para realizar las solicitudes de red.
    var urlSession: URLSession { .shared }
}
