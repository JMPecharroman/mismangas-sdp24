//
//  RoundCornersModifier.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 22/12/24.
//

import SwiftUI

/// Modificador para aplicar esquinas redondeadas a una vista.
struct RoundCornersModifier: ViewModifier {
    
    /// Esquinas a las que se aplicará el radio de redondeo.
    let corners: [ViewCorner]
    
    /// Radio de redondeo de las esquinas.
    let radius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .clipShape(
                .rect(
                    topLeadingRadius: corners.contains(.topLeading) ? radius : 0.0,
                    bottomLeadingRadius: corners.contains(.bottomLeading) ? radius : 0.0,
                    bottomTrailingRadius: corners.contains(.bottomTrailing) ? radius : 0.0,
                    topTrailingRadius: corners.contains(.topTrailing) ? radius : 0.0
                )
            )
    }
}

extension View {
    
    /// Aplica esquinas redondeadas a la vista.
    ///
    /// - Parameters:
    ///   - corners: Esquinas a redondear.
    ///   - radius: Radio del redondeo. Valor por defecto: `12.0`.
    /// - Returns: Una vista con las esquinas redondeadas aplicadas.
    func roundCorners(_ corners: [ViewCorner], radius: CGFloat = 12.0) -> some View {
        modifier(RoundCornersModifier(corners: corners, radius: radius))
    }
}
