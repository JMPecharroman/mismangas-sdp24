//
//  MangaBadgesView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/12/24.
//

import SwiftUI

struct MangaBadgesView: View {
    
    let manga: Manga
    
    var showStatus: Bool = true
    
    var body: some View {
        HStack(spacing: 16.0) {
            Text(manga.yearLabel)
            Text("\(Image(systemName: "star.fill"))")
                .font(.footnote)
            + Text(" \(manga.scoreLabel)")
            if showStatus {
                MangaStatusBadget(status: manga.status)
            }
        }
    }
}

#Preview {
    MangaBadgesView(manga: .preview)
}

struct MangaStatusBadget: View {
    let status: MangaStatus
    
    var body: some View {
        HStack(spacing: 16.0) {
            Text(status.label)
                .font(.subheadline)
                .foregroundStyle(.white)
                .padding(.horizontal, 6.0)
                .padding(.vertical, 2.0)
                .background {
                    RoundedRectangle(cornerRadius: 4.0)
                        .fill(status.tintColor)
                }
        }
    }
}
