//
//  CategoryGroup.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

import Foundation

/// Grupo de categorías de un manga.
enum CategoryGroup: String, CaseIterable {
    
    /// Categoría basada en la temática del manga.
    case theme
    
    /// Categoría basada en el género del manga.
    case genre
    
    /// Categoría basada en la demografía del público objetivo.
    case demographic
}

