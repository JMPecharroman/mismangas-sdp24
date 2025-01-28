//
//  MangasTimelineProvider.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import SwiftUI
import WidgetKit

struct MangasTimelineProvider: TimelineProvider {
    
    let network = Network()
    
    func placeholder(in context: Context) -> MangaEntry {
        .preview
    }
    
    func getSnapshot(in context: Context, completion: @escaping @Sendable (MangaEntry) -> Void) {
        completion(.preview)
    }
    
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<MangaEntry>) -> Void) {
        Task(priority: .high) {
            var mangasEntry: [MangaEntry] = []
            let current: Date = .now
            
            let mangasDTO = try await network.getJSON(request: .createRequest(from: ApiEndPoint.bestMangas), type: ListMangasResponse.self).items.shuffled()
            for mangaDTO in mangasDTO.enumerated() {
                guard let date = Calendar.current.date(byAdding: .minute, value: 5 * mangaDTO.offset, to: current) else { continue }
                guard let manga = mangaDTO.element.toManga else { continue }
                await getMainPicture(url: manga.mainPictute)
                mangasEntry.append(MangaEntry(date: date, manga: manga))
            }
            
            let timeline = Timeline(entries: mangasEntry, policy: .atEnd)
            completion(timeline)
        }
    }
    
    private func getMainPicture(url: URL?) async {
        guard let url else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fileURL = URL.cachesDirectory.appending(path: url.lastPathComponent)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Error: \(error)")
        }
    }
}
