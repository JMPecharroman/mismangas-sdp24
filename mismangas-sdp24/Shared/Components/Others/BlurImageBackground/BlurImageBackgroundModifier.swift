//
//  BlurImageBackgroundModifier.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 4/1/25.
//

import SwiftUI

struct BlurImageBackgroundModifier: ViewModifier {
    
    let url: URL?
    let fullCover: Bool
    
    func body(content: Content) -> some View {
        content
            .background {
                BlurImageBackground(url: url, fullCover: fullCover)
            }
    }
}

extension View {
    func blurImageBackground(url: URL?, fullCover: Bool = false) -> some View {
        modifier(BlurImageBackgroundModifier(url: url, fullCover: fullCover))
    }
}

#Preview {
    VStack {
        Spacer()
    }
    .blurImageBackground(url: Manga.preview.mainPictute)
}
