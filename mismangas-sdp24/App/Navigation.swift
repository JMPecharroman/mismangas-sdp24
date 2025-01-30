//
//  Navigation.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 10/12/24.
//

import SwiftUI

/// Define destinos de navegación para distintas entidades de la aplicación.
struct NavigationDestinationsModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Author.self) {
                AuthorView($0)
            }
            .navigationDestination(for: Category.self) {
                MangasByCategoryView($0)
            }
            .navigationDestination(for: CategoryGroup.self) {
                CategoryView(group: $0)
            }
            .navigationDestination(for: CollectionManga.self) {
                CollectionMangaView($0)
            }
            .navigationDestination(for: Manga.self) {
                MangaView($0)
            }
            .navigationDestination(for: Destination.self) {
                switch $0 {
                    case .mangasByCategory(let category, let group):
                        MangasByCategoryView(category, group: group)
                }
            }
    }
}

extension View {
    /// Aplica `NavigationDestinationsModifier` a cualquier vista.
    /// - Returns: Una vista modificada con los destinos de navegación predefinidos.
    func navigationDestinations() -> some View {
        modifier(NavigationDestinationsModifier())
    }
}

/// Enum que define los destinos de navegación personalizados dentro de la aplicación.
/// Utilizado en conjunto con `navigationDestination(for:)`.
enum Destination: Hashable {
    case mangasByCategory(category: String, group: CategoryGroup)
}

