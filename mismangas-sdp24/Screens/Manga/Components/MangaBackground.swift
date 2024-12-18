//
//  MangaBackground.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/12/24.
//

import SwiftUI

struct MangaBackground: View {
    
    let manga: Manga
    
    var body: some View {
        ImageCached(url: manga.mainPictute)
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
    VStack {
        Spacer()
    }
    .background {
        MangaBackground(manga: .preview)
    }
}
