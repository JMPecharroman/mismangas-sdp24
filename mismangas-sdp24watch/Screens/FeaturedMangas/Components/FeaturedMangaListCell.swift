//
//  FeaturedMangaListCell.swift
//  mismangas-sdp24watch Watch App
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import SwiftUI

struct FeaturedMangaListCell: View {
    
    let manga: Manga
    
    var body: some View {
        HStack {
            Poster(url: manga.mainPictute)
                .frame(height: 44.0)
                .padding(.vertical, -10.0)
                .padding(.trailing, 4.0)
            VStack(alignment: .leading, spacing: 2.0) {
                Text(manga.title)
                    .lineLimit(1)
                MangaBadgesView(manga: manga, showStatus: false)
            }
        }
    }
}

#Preview {
    FeaturedMangaListCell(manga: .preview)
}
