//
//  MangaListCell.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import SwiftUI

struct MangaListCell: View {
    
    let manga: Manga
    
    var body: some View {
        NavigationLink {
            MangaView(manga: manga)
        } label: {
            HStack {
                Poster(manga: manga)
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(manga.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .padding(.top)
                    MangaBadgesView(manga: manga)
                        .font(.callout)
                    if let synopsis = manga.synopsis {
                        Text(synopsis)
                            .font(.caption)
                            .lineLimit(5)
                            .layoutPriority(0.5)
                    }
                    Spacer()
                }
                .padding(.leading)
                .padding(.vertical, -12.0)
            }
            .frame(height: 120.0)
        }
    }
}

#Preview {
    NavigationStack {
        List {
            MangaListCell(manga: .preview)
        }
        .navigationTitle("MangaListCell")
        .navigationBarTitleDisplayMode(.inline)
    }
}
