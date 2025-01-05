//
//  CollectionMangaHeaderView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 4/1/25.
//

import SwiftUI

struct CollectionMangaHeaderView: View {
    
    let collectionManga: CollectionManga
    
    var body: some View {
        VStack(spacing: 8.0) {
            Poster(url:collectionManga.cover)
                .frame(height: 180.0)
            Text(collectionManga.title)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
    }
}

#Preview {
    CollectionMangaHeaderView(collectionManga: .preview)
}
