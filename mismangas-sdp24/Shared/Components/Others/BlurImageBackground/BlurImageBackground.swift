//
//  BlurImageBackgroundModifier.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 4/1/25.
//

import SwiftUI

struct BlurImageBackground: View {
    
    let url: URL?
    var fullCover: Bool
    
    var body: some View {
        ImageCached(url: url)
            .scaledToFill()
            .blur(radius: 12.0)
//                .overlay(.ultraThinMaterial.opacity(1))
            .overlay {
                if !fullCover {
                    LinearGradient(
                        colors: [
                            .clear,
                            Color(backgroundColor).opacity(0.7),
                            Color(backgroundColor)
                        ],
                        startPoint: .top,
                        endPoint: endPoint
                    )
                }
            }
            .ignoresSafeArea()
    }
    
    private var backgroundColor: UIColor {
        #if os(watchOS)
        .black
        #else
        .systemBackground
        #endif
    }
    
    private var endPoint: UnitPoint {
        #if os(watchOS)
        .init(x: 0.5, y: 1.0)
        #else
        .init(x: 0.5, y: 0.75)
        #endif
    }
}

#Preview {
    BlurImageBackground(url: Manga.preview.mainPictute, fullCover: false)
}
