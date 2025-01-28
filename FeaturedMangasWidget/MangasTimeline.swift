//
//  MangasTimeline.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import SwiftUI
import WidgetKit

struct MangaEntry: TimelineEntry, Sendable {
    var date: Date
    var manga: Manga
}

extension MangaEntry {
    static let preview = MangaEntry(date: .now, manga: .preview)
}

extension MangaDTO {
    static let preview: MangaDTO = MangaDTO(
        id: 42,
        title: "Dragon Ball",
        titleEnglish: nil,
        titleJapanese: nil,
        background: nil,
        mainPicture: "https://cdn.myanimelist.net/images/manga/1/267793l.jpg",
        volumes: 42,
        chapters: 520,
        status: "finished",
        score: 8.41,
        url: "https://myanimelist.net/manga/42/Dragon_Ball",
        sypnosis: "Bulma, a headstrong 16-year-old girl, is on a quest to find the mythical Dragon Balls—seven scattered magic orbs that grant the finder a single wish. She has but one desire in mind: a perfect boyfriend. On her journey, Bulma stumbles upon Gokuu Son, a powerful orphan who has only ever known one human besides her. Gokuu possesses one of the Dragon Balls, it being a memento from his late grandfather. In exchange for it, Bulma invites Gokuu to be a companion in her travels.\n\nBy Bulma's side, Gokuu discovers a world completely alien to him. Powerful enemies embark on their own pursuits of the Dragon Balls, pushing Gokuu beyond his limits in order to protect Bulma and their growing circle of allies. However, Gokuu has secrets unbeknownst to even himself; the incredible strength within him stems from a mysterious source, one that threatens the many people he grows to hold dear.\n\nAs his prowess in martial arts flourishes, Gokuu attracts stronger opponents whose villainous plans could collapse beneath his might. He undertakes the endless venture of combat training to defend his loved ones and the fate of the planet itself.\n\n[Written by MAL Rewrite]",
        startDate: "1984-11-20T00:00:00Z",
        endDate: nil,
        authors: [],
        demographics: [],
        genres: [],
        themes: []
    )
}

extension Manga {
    static let preview: Manga = MangaDTO.preview.toManga!
}
