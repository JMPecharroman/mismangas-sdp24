//
//  MangaHeader.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 19/12/24.
//

import SwiftUI

struct MangaHeader: View {
    
    @State private var textSheetData: TextSheetData?
    
    let manga: Manga
    
    var body: some View {
        VStack {
            VStack(spacing: 8.0) {
                Poster(manga: manga)
                    .frame(width: 150.0)
                    .padding()
                
                Text(manga.title)
                    .font(.title)
                    .bold()
                    .padding(.horizontal, 16.0)
                
                if let titleJapanese = manga.titleJapanese, !titleJapanese.isEmpty {
                    Text(titleJapanese)
                        .font(.subheadline)
                        .lineLimit(2)
                        .padding(.horizontal, 16.0)
                        .frame(maxWidth: 360.0)
                }
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            
            VStack(spacing: 16.0) {
                MangaBadgesView(manga: manga)
                    .font(.headline)
                
                if let synopsis = manga.synopsis {
//                    Button {
//                        textSheetData = TextSheetData(title: manga.title, text: synopsis)
//                    } label: {
                        Text(synopsis)
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .overlay {
                                VStack {
                                    Spacer()
                                    HStack(spacing: 0.0) {
                                        Spacer()
                                        VStack {
                                            Text("")
                                                .font(.callout)
                                                .frame(width: 28.0)
                                        }
                                        .background {
                                            LinearGradient(
                                                colors: [
                                                    .clear,
                                                    Color(.systemBackground)
                                                ],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        }
                                        Button {
                                            textSheetData = TextSheetData(title: manga.title, text: synopsis)
                                        } label: {
                                            Text("Ver más")
                                                .font(.callout)
                                        }
                                        .padding(.leading, 4.0)
                                        .background {
                                            Color(.systemBackground)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: 360.0, alignment: .center)
//                    }
//                    .buttonStyle(.plain)
                }
            }
            .frame(minHeight: 50.0)
            .frame(maxWidth: .infinity)
            .background {
                LinearGradient(
                    colors: [
                        .clear,
                        Color(.systemBackground)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
        .textSheet(data: $textSheetData)
    }
}

#Preview {
    NavigationStack {
        MangaView(vm: .preview)
    }
}
