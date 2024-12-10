//
//  NavigationDestinations.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 10/12/24.
//

import SwiftUI

struct NavigationDestinationsModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Manga.self) {
                MangaView(manga: $0)
            }
    }
}

extension View {
    func navigationDestinations() -> some View {
        modifier(NavigationDestinationsModifier())
    }
}

