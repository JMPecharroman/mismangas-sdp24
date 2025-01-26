//
//  CollectionMangaListCell.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import SwiftUI

struct CollectionMangaListCell: View {
    
    let manga: CollectionManga
    
    var body: some View {
        HStack {
            Poster(url: manga.cover)
                .frame(height: 44.0)
                .padding(.vertical, -10.0)
                .padding(.trailing, 4.0)
            VStack(alignment: .leading, spacing: 2.0) {
                Text(manga.title)
                    .lineLimit(1)
                HStack {
                    if manga.totalVolumes > 0 {
                        if manga.completeCollection {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(.green)
                        }
                        Text(manga.volumesToReadLabel)
                    } else {
                        Image(systemName: "xmark.circle")
                            .foregroundStyle(.red)
                        Text("No hay volúmenes disponibles")
                    }
                }
                .font(.footnote)
                .foregroundStyle(.secondary)
                .lineLimit(1)
            }
        }
    }
}

#Preview {
    CollectionMangaListCell(manga: .preview)
}
