//
//  MangaWidgetView.swift
//  FeaturedMangasWidgetExtension
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import SwiftUI
import WidgetKit

struct MangaWidgetView: View {
    @Environment(\.widgetFamily) var family
    
    let mangaEntry: MangaEntry
    
    var body: some View {
        switch family {
            case .systemSmall:
                bodySmall
            default:
                bodyMedium
        }
    }
    
    var bodyMedium: some View {
        HStack {
            if let picture = getMainPicture() {
                Image(uiImage: picture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90.0)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .padding(.vertical)
            }
            VStack(alignment: .leading, spacing: 4.0) {
                Spacer()
                Text(mangaEntry.manga.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .padding(.top, 8.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                MangaBadgesView(manga: mangaEntry.manga)
                if let synopsis = mangaEntry.manga.synopsis {
                    Text(synopsis)
                        .font(.subheadline)
                        .lineLimit(3)
                        .layoutPriority(0.9)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.leading, 8.0)
            .padding(.vertical)
        }
        .containerBackground(for: .widget) {
            ZStack {
                Color.black
                if let picture = getMainPicture() {
                    Image(uiImage: picture)
                        .resizable()
                        .scaledToFill()
                        .opacity(0.25)
                }
            }
        }
    }
    
    var bodySmall: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Spacer()
            Text(mangaEntry.manga.title)
                .fontWeight(.semibold)
                .lineLimit(2)
                .padding(.top, 8.0)
                .frame(maxWidth: .infinity, alignment: .leading)
            MangaBadgesView(manga: mangaEntry.manga, showStatus: false)
            MangaStatusBadget(status: mangaEntry.manga.status)
        }
        .containerBackground(for: .widget) {
            ZStack {
                Color.black
                if let picture = getMainPicture() {
                    Image(uiImage: picture)
                        .resizable()
                        .scaledToFill()
                        .opacity(0.4)
                }
            }
        }
    }
    
    // TODO: Mover esto de la vista
    
    private func getMainPicture() -> UIImage? {
        guard let url = mangaEntry.manga.mainPictute else { return nil }
        let fileURL = URL.cachesDirectory.appending(path: url.lastPathComponent)
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            do {
                let data = try Data(contentsOf: fileURL)
                return UIImage(data: data)
            } catch {
                print("Error: \(error)")
                return nil
            }
        } else {
            return UIImage(named: url.lastPathComponent)
        }
    }
}

#Preview(as: .systemMedium) {
    MangaWidget()
} timeline: {
    MangaEntry.preview
}
