//
//  FeaturedMangasWidgetBundle.swift
//  FeaturedMangasWidget
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import WidgetKit
import SwiftUI

@main
struct FeaturedMangasWidgetBundle: WidgetBundle {
    var body: some Widget {
        MangaWidget()
    }
}

struct MangaWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Featured mangas", provider: MangasTimelineProvider()) { entry in
            MangaWidgetView(mangaEntry: entry)
        }
        .configurationDisplayName("Mangas destacados")
        .description("Muestra los mangas más destacados")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
