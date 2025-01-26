//
//  CardBackgroundModifier.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 4/1/25.
//

import SwiftUI

struct CardBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .fill(Color(backgroundColor))
            }
    }
    
    private var backgroundColor: UIColor {
        #if os(watchOS)
        .darkGray
        #else
        .secondarySystemBackground
        #endif
    }
}

extension View {
    func cardBackground() -> some View {
        modifier(CardBackgroundModifier())
    }
}

#Preview {
    Text("Preview")
        .padding()
        .cardBackground()
}
