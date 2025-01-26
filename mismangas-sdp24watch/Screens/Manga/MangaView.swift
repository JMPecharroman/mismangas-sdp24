//
//  MangaView.swift
//  mismangas-sdp24watch Watch App
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import SwiftUI

struct MangaView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State var vm: MangaViewModel
    @State var collectionMangaVM: CollectionMangaViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 12.0) {
                VStack(spacing: 4.0) {
                    Poster(manga: vm.manga)
                        .frame(width: 60.0)
                        .padding()
                    
                    Text(vm.manga.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 4.0)
                    
                    if let titleJapanese = vm.manga.titleJapanese, !titleJapanese.isEmpty {
                        Text(titleJapanese)
                            .font(.footnote)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 4.0)
                    }
                    
                    HStack {
                        Text(vm.manga.yearLabel)
                        Text("\(Image(systemName: "star.fill"))")
                            .font(.footnote)
                        + Text(" \(vm.manga.scoreLabel)")
                    }
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    
                    Text(vm.manga.status.label)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6.0)
                        .padding(.vertical, 2.0)
                        .background {
                            RoundedRectangle(cornerRadius: 4.0)
                                .fill(vm.manga.status.tintColor)
                        }
                }
                
                if let collectionData = collectionMangaVM.data {
                    NavigationLink {
                        CollectionMangaView(collectionData)
                    } label: {
                        Text("Ver en mi colección")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                } else {
                    Button {
                        collectionMangaVM.addToCollection(vm.manga)
                    } label: {
                        Text("Añadir a mi colección")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .buttonStyle(.borderedProminent)
                }
                if let synopsis = vm.manga.synopsis {
                    Text(synopsis)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal)
        }
        .blurImageBackground(url: vm.manga.mainPictute)
        .loading(vm.isLoading || collectionMangaVM.isLoading)
        .onAppear {
            collectionMangaVM.onAppear(modelContext: modelContext)
        }
    }
}

extension MangaView {
    init(_ manga: Manga) {
        self.init(vm: .init(manga), collectionMangaVM: .init(manga: manga))
    }
}

#Preview {
    NavigationStack {
        MangaView(vm: MangaViewModel(.preview), collectionMangaVM: .preview)
    }
}
