//
//  MangaView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 10/12/24.
//

import SwiftUI

struct MangaView: View {
    
    @State var vm: MangaViewModel
    @State private var textSheetData: TextSheetData?
    
    private let columns = [
        GridItem(.adaptive(minimum: 90.0, maximum: 120.0), spacing: 4.0)
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 0.0) {
                VStack(spacing: 8.0) {
                    Poster(manga: vm.manga)
                        .frame(width: 150.0)
                        .padding()
                    
                    Text(vm.manga.title)
                        .font(.title)
                        .bold()
                        .padding(.horizontal, 16.0)
                    
                    if !vm.manga.titleJapanese.isEmpty {
                        Text(vm.manga.titleJapanese)
                            .font(.subheadline)
                            .lineLimit(2)
                            .padding(.horizontal, 16.0)
                            .frame(maxWidth: 360.0)
                            .padding(.bottom)
                    }
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                
                VStack(spacing: 12.0) {
                    MangaBadgesView(manga: vm.manga)
                        .font(.headline)
                    
                    Button {
                        textSheetData =  TextSheetData(title: vm.manga.title, text: vm.manga.synopsis)
                    } label: {
                        Text(vm.manga.synopsis)
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .padding(.horizontal)
                            .frame(maxWidth: 360.0, alignment: .center)
                    }
                    .buttonStyle(.plain)
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

                LazyVStack(alignment: .leading) {
                    SectionHeader(text: "Autores")
                        .padding(.horizontal)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            VStack {
                                Image(systemName: "person")
                                    .resizable()
                                    .aspectRatio(1.0, contentMode: .fill)
                                    .frame(width: 90.0)
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

                    SectionHeader(text: "Categorías", button: "Ver todas") {
                        MangaCategoriesView(manga: vm.manga)
                    }
                    .padding(.horizontal)
                    
                    LazyVGrid(columns: columns, spacing: 4.0) {
                        ForEach(vm.manga.categories, id: \.self) { category in
                            Text(category.name)
                                .font(.caption)
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                                .frame(height: 32.0)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .background {
                                    Capsule(style: .continuous)
                                        .fill(Color(.systemGray5))
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)

                    VStack(alignment: .leading) {
                        if let background = vm.manga.background {
                            SectionHeader(text: "Información", button: "Ver más") {
                                textSheetData =  TextSheetData(title: vm.manga.title, text: background)
                            }
                            Text(background)
                                .font(.callout)
                                .lineLimit(3)
                        }
                        SectionHeader(text: "Ficha técnica")
                        VStack(alignment: .leading, spacing: 12.0) {
                            MangaData(data: "Título japonés", value: "dejkqb eqwkj deqwlkb")
                            MangaData(data: "Título inglés", value: "sdkjbf odjk fn")
                            MangaData(data: "Fecha de inicio", value: "5 de junio de 2008")
                            MangaData(data: "Fecha de finalización", value: "23 de agosto de 2013")
                            MangaData(data: "Número de personajes", value: "326")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemBackground))
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
            }
        }
        .background {
            ImageCached(url: vm.manga.mainPictute)
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
        .navigationTitle(vm.manga.title)
        .navigationBarTitleDisplayMode(.inline)
        .textSheet(data: $textSheetData)
    }
}

#Preview {
    NavigationStack {
        MangaView(vm: MangaViewModel(.preview))
    }
}

struct MangaData: View {
    
    let data: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(data)
                .font(.headline)
            Text(value)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}
