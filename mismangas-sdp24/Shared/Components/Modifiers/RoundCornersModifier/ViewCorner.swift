//
//  ViewCorner.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 30/1/25.
//

import Foundation

/// Representa las esquinas de una vista.
enum ViewCorner {
    
    /// Esquina superior izquierda.
    case topLeading
    
    /// Esquina superior derecha.
    case topTrailing
    
    /// Esquina inferior izquierda.
    case bottomLeading
    
    /// Esquina inferior derecha.
    case bottomTrailing
}

extension Array where Element == ViewCorner {
    
    /// Todas las esquinas de la vista.
    static var allCorners: [ViewCorner] { [.topLeading, .topTrailing, .bottomLeading, .bottomTrailing] }
    
    /// Solo las esquinas superiores.
    static var top: [ViewCorner] { [.topLeading, .topTrailing] }
    
    /// Solo las esquinas inferiores.
    static var bottom: [ViewCorner] { [.bottomLeading, .bottomTrailing] }
    
    /// Sin esquinas redondeadas.
    static var none: [ViewCorner] { [] }
}
