//
//  CollectionMangaListCell.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 2/1/25.
//

import SwiftUI

struct CollectionMangaListCell: View {
    
    let manga: CollectionManga
    
    var body: some View {
        NavigationLink(value: manga) {
            HStack {
                Poster(url: manga.cover)
                    .frame(height: 80.0)
                    .padding(.vertical, -6.0)
                    .padding(.trailing, 8.0)
                VStack(alignment: .leading, spacing: 6.0) {
                    Text(manga.title)
                        .font(.headline)
                        .lineLimit(2)
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
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            CollectionMangaListCell(manga: .preview)
        }
    }
}
