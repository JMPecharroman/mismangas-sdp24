//
//  MangasCarrousel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

import SwiftUI

struct MangasCarrousel: View {
    
    let mangas: [Manga]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16.0) {
                ForEach(mangas) { manga in
                    NavigationLink(value: manga) {
                        ImageCached(url: manga.mainPictute)
                            .scaledToFill()
                            .frame(width: 150.0, height: 225.0)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12.0))
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 4.0)
            .padding(.bottom)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    MangasCarrousel(mangas: .preview)
}
