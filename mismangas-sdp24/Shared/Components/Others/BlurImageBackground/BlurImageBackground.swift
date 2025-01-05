//
//  BlurImageBackgroundModifier.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 4/1/25.
//

import SwiftUI

struct BlurImageBackground: View {
    
    let url: URL?
    
    var body: some View {
        ImageCached(url: url)
            .scaledToFill()
            .blur(radius: 12.0)
//                .overlay(.ultraThinMaterial.opacity(1))
            .overlay {
                LinearGradient(
                    colors: [
                        .clear,
                        Color(.systemBackground).opacity(0.7),
                        Color(.systemBackground)
                    ],
                    startPoint: .top,
                    endPoint: .init(x: 0.5, y: 0.75)
                )
            }
            .ignoresSafeArea()
    }
}

#Preview {
    BlurImageBackground(url: Manga.preview.mainPictute)
}
