//
//  MangaInfoSection.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/12/24.
//

import SwiftUI

struct MangaInfoSection: View {
    
    let manga: Manga
    
    @State private var textSheetData: TextSheetData?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let background = manga.background {
                SectionHeader(text: "Información", button: "Ver más") {
                    textSheetData =  TextSheetData(title: manga.title, text: background)
                }
                Text(background)
                    .font(.callout)
                    .lineLimit(3)
            }
            SectionHeader(text: "Ficha técnica")
            VStack(alignment: .leading, spacing: 12.0) {
                if let titleJapanese = manga.titleJapanese {
                    MangaData(data: "Título japonés", value: titleJapanese)
                }
                if let titleEnglish = manga.titleEnglish {
                    MangaData(data: "Título inglés", value: titleEnglish)
                }
                if let startDateLabel = manga.startDateLabel {
                    MangaData(data: "Fecha de inicio", value: startDateLabel)
                }
                if let endDateLabel = manga.endDateLabel {
                    MangaData(data: "Fecha de finalización", value: endDateLabel)
                }
                if manga.chapters > 0 {
                    MangaData(data: "Número de personajes", value: manga.chaptersLabel)
                }
                MangaData(data: "Número de volúmenes", value: manga.volumesLabel)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.bottom)
        .background(Color(.secondarySystemBackground))
        .textSheet(data: $textSheetData)
    }
}

#Preview {
    ScrollView {
        VStack {
            MangaInfoSection(manga: .preview)
        }
    }
}
