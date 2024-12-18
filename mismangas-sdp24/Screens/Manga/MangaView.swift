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
                
                VStack(spacing: 16.0) {
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
                    
                    MangaAuthorsCarrousel(authors: vm.manga.authors)

                    SectionHeader(text: "Categorías", button: "Ver todas") {
                        MangaCategoriesView(manga: vm.manga)
                    }
                    .padding(.horizontal)
                    MangaCategoriesGrid(manga: vm.manga)
                    
                    MangaInfoSection(manga: vm.manga)
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
            }
        }
        .background {
            MangaBackground(manga: vm.manga)
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
