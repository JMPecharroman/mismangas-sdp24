//
//  MangaBadgesView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/12/24.
//

import SwiftUI

struct MangaBadgesView: View {
    
    let manga: Manga
    
    var body: some View {
        HStack(spacing: 16.0) {
            Text(manga.yearLabel)
            Text("\(Image(systemName: "star.fill"))")
                .font(.footnote)
            + Text(" \(manga.scoreLabel)")
            Text(manga.status.label)
                .font(.subheadline)
                .padding(.horizontal, 6.0)
                .padding(.vertical, 2.0)
                .background {
                    RoundedRectangle(cornerRadius: 4.0)
                        .fill(manga.status.tintColor)
                }
        }
    }
}

#Preview {
    MangaBadgesView(manga: .preview)
}
