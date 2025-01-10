//
//  Poster.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import SwiftUI

struct Poster: View {
    
    let url: URL?
    
    var body: some View {
        VStack {
            ImageCached(url: url)
                .aspectRatio(150.0 / 225.0, contentMode: .fit)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                .padding(.vertical, 4.0)
        }
    }
}

extension Poster {
    init(manga: Manga) {
        self.init(url: manga.mainPictute)
    }
}

#Preview {
    List {
        HStack {
            Poster(manga: .preview)
                .frame(width: 80.0)
        }
        .listRowBackground(Color.red)
    }
}
