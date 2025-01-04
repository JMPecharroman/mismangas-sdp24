//
//  BlurImageBackgroundModifier.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 4/1/25.
//

import SwiftUI

struct BlurImageBackgroundModifier: ViewModifier {
    
    let url: URL?
    
    func body(content: Content) -> some View {
        content
            .background {
                BlurImageBackground(url: url)
            }
    }
}

extension View {
    func blurImageBackground(url: URL?) -> some View {
        modifier(BlurImageBackgroundModifier(url: url))
    }
}

#Preview {
    VStack {
        Spacer()
    }
    .blurImageBackground(url: Manga.preview.mainPictute)
}
