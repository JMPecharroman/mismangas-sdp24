//
//  RoundCornersModifier.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 22/12/24.
//

import SwiftUI

struct RoundCornersModifier: ViewModifier {
    
    let corners: [ViewCorner]
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
    func roundCorners(_ corners: [ViewCorner], radius: CGFloat = 12.0) -> some View {
        modifier(RoundCornersModifier(corners: corners, radius: radius))
    }
}

enum ViewCorner {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
}

extension Array where Element == ViewCorner {
    static var allCorners: [ViewCorner] { [.topLeading, .topTrailing, .bottomLeading, .bottomTrailing] }
    static var top: [ViewCorner] { [.topLeading, .topTrailing] }
    static var bottom: [ViewCorner] { [.bottomLeading, .bottomTrailing] }
    static var none: [ViewCorner] { [] }
}
