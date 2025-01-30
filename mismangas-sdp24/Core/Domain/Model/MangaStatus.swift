//
//  MangaStatus.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/12/24.

import Foundation

/// Estado de publicación de un manga.
enum MangaStatus: Equatable, Hashable {
    
    /// La publicación del manga ha sido descontinuada.
    case discontinued
    
    /// El manga ha finalizado su publicación.
    case finished
    
    /// El manga está en pausa temporal.
    case onHiatus
    
    /// El manga se encuentra en publicación activa.
    case publishing
    
    /// Estado desconocido del manga, almacenando el valor recibido.
    case unknown(String)
    
    /// Inicializa el estado del manga a partir de un valor en cadena de texto.
    ///
    /// - Parameter rawValue: Cadena de texto representando el estado del manga.
    init(rawValue: String) {
        switch rawValue.lowercased() {
            case "currently_publishing": self = .publishing
            case "discontinued": self = .discontinued
            case "on_hiatus": self = .onHiatus
            case "finished": self = .finished
            default:
                assertionFailure("MangaStatus invalid rawValue: \(rawValue)")
                self = .unknown(rawValue)
        }
    }
}
