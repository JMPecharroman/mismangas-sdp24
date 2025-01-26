//
//  CollectionMangaView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import SwiftUI

struct CollectionMangaView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State var vm: CollectionMangaViewModel
    
    @State private var selectedVolume: VolumeData?
    
    var body: some View {
        List {
            Section {
                HStack(spacing: 8.0) {
                    Poster(url: vm.data?.cover)
                        .frame(height: 64.0)
                    VStack(alignment: .leading) {
                        Text(vm.data?.title ?? "-")
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        if let totalVolumesLabel = vm.data?.totalVolumesLabel {
                            Text(totalVolumesLabel)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
            Section {
                if vm.volumesData.isEmpty {
                    HStack {
                        Image(systemName: "xmark.circle")
                            .foregroundStyle(.red)
                        Text("No hay volúmenes disponibles")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                } else {
                    ForEach(vm.volumesData) { volume in
                        Button {
                            selectedVolume = volume
                        } label: {
                            HStack {
                                Text("Volumen \(volume.id)")
                                    .layoutPriority(0.9)
                                Spacer()
                                Image(systemName: volume.isOwned ? "books.vertical" : "cart")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(volume.isOwned ? .white : .blue)
                                    .frame(width: 18.0, height: 18.0)
                                    .padding(4.0)
                                    .background(.blue.opacity(volume.isOwned ? 1.0 : 0.3))
                                    .clipShape(Circle())
                                Image(systemName: volume.isRead ? "checkmark" : "eye")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(volume.isRead ? .white : .green)
                                    .frame(width: 18.0, height: 18.0)
                                    .padding(4.0)
                                    .background(.green.opacity(volume.isRead ? 1.0 : 0.3))
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(vm.data?.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .blurImageBackground(url: vm.data?.cover)
        .sheet(item: $selectedVolume) {
            CollectionMangaVolumeView(vm: $vm, volume: $0)
        }
        .onAppear {
            vm.onAppear(modelContext: modelContext)
        }
    }
}

extension CollectionMangaView {
    init(_ manga: CollectionMangaSD) {
        self.init(vm: CollectionMangaViewModel(data: manga.toCollectionManga))
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        CollectionMangaView(vm: .preview)
    }
}
