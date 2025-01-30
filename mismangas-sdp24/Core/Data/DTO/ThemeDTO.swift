//
//  ThemeDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Tema asociado a un manga.
struct ThemeDTO: Codable {
    
    /// Identificador único del tema.
    let id: String
    
    /// Nombre del tema.
    let theme: String
}
