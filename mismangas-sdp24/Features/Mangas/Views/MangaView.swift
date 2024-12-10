//
//  MangaView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 10/12/24.
//

import SwiftUI

struct MangaView: View {
    
    let manga: Manga
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 0.0) {
                VStack(spacing: 8.0) {
                    ImageCached(url: manga.mainPictute)
                        .frame(width: 150.0, height: 225.0)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                        .padding()
                    
                    Text(manga.title)
                        .font(.title)
                        .bold()
                        .padding(.horizontal, 16.0)
                    
                    if !manga.titleJapanese.isEmpty {
                        Text(manga.titleJapanese)
                            .font(.subheadline)
                            .lineLimit(2)
                            .padding(.horizontal, 16.0)
                            .frame(maxWidth: 360.0)
                            .padding(.bottom, 4.0)
                    }
                    
//                    HStack {
//                        Text("2021")
//                            .font(.headline)
//                        Text("Finished")
//                            .font(.subheadline)
//                            .padding(.horizontal, 6.0)
//                            .padding(.vertical, 2.0)
//                            .background {
//                                RoundedRectangle(cornerRadius: 4.0)
//                                    .fill(.red)
//                            }
//                    }
                    
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                
                HStack {
                    Text("2021")
                        .font(.headline)
                    Text("Finished")
                        .font(.subheadline)
                        .padding(.horizontal, 6.0)
                        .padding(.vertical, 2.0)
                        .background {
                            RoundedRectangle(cornerRadius: 4.0)
                                .fill(.red)
                        }
                }
                .frame(height: 50.0)
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
                
                LazyVStack(alignment: .leading) {
//                    HStack {
//                        Image(systemName: "star.fill")
//                        Text("5.0")
//                            .padding(.leading, -4.0)
//                        Text("Finished")
//                            .padding(.horizontal, 8.0)
//                            .padding(.vertical, 4.0)
//                            .background {
//                                RoundedRectangle(cornerRadius: 4.0)
//                                    .fill(.red)
//                            }
//                    }
                    
                    SectionHeader(text: "Autores")
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            VStack {
                                Image(systemName: "person")
                                    .resizable()
                                    .aspectRatio(1.0, contentMode: .fill)
                                    .frame(width: 80.0)
                                    .background(.regularMaterial)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                                    .padding(8.0)
                                Text("George Morikawa")
                                    .font(.subheadline)
                                    .lineLimit(1)
                                Text("Story & Art")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                            .frame(width: 120.0)
                        }
                        .padding(.horizontal)
                    }
                    
                    VStack(alignment: .leading) {
                        SectionHeader(text: "Sinopsis")
                        Text(manga.synopsis)
                            .font(.callout)
                            .lineLimit(3)
                            .padding(.top, -4.0)
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemBackground))
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
                
//                VStack(alignment: .leading, spacing: 12) {
                    
                    
                    
//                    HStack(spacing: 16) {
//                        Label(String(format: "%.1f", manga.score), systemImage: "star.fill")
//                            .foregroundStyle(.yellow)
//                        if let volumes = manga.volumes {
//                            Text("\(volumes) volumes")
//                        }
//                        if let date = manga.startDate {
//                            Text(date.formatted(.dateTime.year()))
//                        }
//                    }
//                    .font(.headline)
                    
//                    if let authors = manga.authors.first {
//                        Text("By \(authors.firstName) \(authors.lastName)")
//                            .font(.subheadline)
//                            .foregroundStyle(.secondary)
//                    }
//                }
//                .padding()
//                .background(.blue)
//                .background(.ultraThinMaterial)
                
                
            }
//            .frame(maxWidth: .infinity)
//            .background(.red)
        }
        .background {
            ImageCached(url: manga.mainPictute)
                .scaledToFill()
                .blur(radius: 12.0)
//                .overlay(.ultraThinMaterial.opacity(1))
                .overlay {
                    LinearGradient(
                        colors: [
                            .clear,
                            Color(.systemBackground).opacity(0.7),
                            Color(.systemBackground)
                        ],
                        startPoint: .top,
                        endPoint: .init(x: 0.5, y: 0.75)
                    )
                }
                .ignoresSafeArea()
        }
        .navigationTitle(manga.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MangaView(manga: .preview)
    }
}
