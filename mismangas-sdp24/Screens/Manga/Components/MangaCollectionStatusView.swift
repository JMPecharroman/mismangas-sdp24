//
//  MangaCollectionStatusView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

import SwiftData
import SwiftUI

struct MangaCollectionStatusView: View {
    @Environment(\.modelContext) private var modelContext
    
    let manga: Manga
    
    @State var vm: CollectionMangaViewModel
    @State private var firstLoadingCompleted: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            if !firstLoadingCompleted && vm.isLoading {
                SectionLoadingView(message: "Cargando los datos de tu colección...", height: 80.0)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8.0)
                            .fill(.regularMaterial)
                    }
                    .padding(.horizontal)
            } else {
                Group {
                    if let collectionData = vm.data {
                        if collectionData.totalVolumes > 0 {
                            NavigationLink(value: collectionData) {
                                CollectionMangaGaugesView(collectionManga: collectionData)
                                    .padding(.horizontal)
                            }
                            .buttonStyle(.plain)
                        } else {
                            NavigationLink(value: collectionData) {
                                Text("Ver en mi colección")
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .cardBackground()
                            }
                            .buttonStyle(.plain)
                            .padding(.horizontal)
                        }
                        if !collectionData.completeCollection {
                            Button {
                                vm.markAsRead(volume: collectionData.nextVolumeToRead)
                            } label: {
                                Text(collectionData.setNextVolumeAsReadingLabel)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.horizontal)
                            .padding(.top, 8.0)
                        }
                    } else {
                        Button {
                            vm.addToCollection(manga)
                        } label: {
                            Text("Añadir a mi colección")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.horizontal)
                        .padding(.top, 8.0)
                    }
                }
                .onFirstAppear {
                    firstLoadingCompleted = true
                }
            }
        }
        .padding(.top)
        .onAppear {
            vm.onAppear(modelContext: modelContext)
        }
    }
}

extension MangaCollectionStatusView {
    init(manga: Manga) {
        self = MangaCollectionStatusView(manga: manga, vm: .init(manga: manga))
    }
}

#Preview(traits: .sampleData) {
    MangaCollectionStatusView(manga: .preview, vm: .preview)
        .environment(CollectionViewModel(repository: .preview))
}
