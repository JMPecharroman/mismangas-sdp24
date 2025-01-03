//
//  MangaCollectionStatusView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

import SwiftData
import SwiftUI

struct MangaCollectionStatusView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(CollectionViewModel.self) private var collectionVM
    @State var mangaViewModel: MangaViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            if mangaViewModel.collectionIsLoading {
                SectionLoadingView(message: "Cargando los datos de tu colección...", height: 80.0)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8.0)
                            .fill(.regularMaterial)
                    }
                    .padding(.horizontal)
            } else if let collectionData = mangaViewModel.collectionData {
                if mangaViewModel.manga.volumes > 0 {
                    VStack(spacing: 16.0) {
                        HStack {
                            VStack {
                                Text(mangaViewModel.manga.volumesLabel)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .frame(width: 60.0, height: 60.0, alignment: .center)
                                    .background {
                                        Circle()
                                            .strokeBorder(.orange, lineWidth: 6.0)
                                    }
                                Text("Volúmenes")
                                    .foregroundStyle(.orange)
                                    .fontWeight(.semibold)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            VStack {
                                Gauge(value: Double(collectionData.volumesOwned.count) / Double(mangaViewModel.manga.volumes)) {
                                    Text("Value")
                                } currentValueLabel: {
                                    Text("\(collectionData.volumesOwnedCountLabel)")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                                .gaugeStyle(.accessoryCircularCapacity)
                                .tint(.blue)
                                Text("Comprados")
                                    .foregroundStyle(.blue)
                                    .fontWeight(.semibold)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            VStack {
                                Gauge(value: 0.3) {
                                    Text("Value")
                                } currentValueLabel: {
                                    Text("12")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                                .gaugeStyle(.accessoryCircularCapacity)
                                .tint(.green)
                                Text("Leídos")
                                    .foregroundStyle(.green)
                                    .fontWeight(.semibold)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            //                            Spacer()
                        }
                        
                        //                        Button {
                        //
                        //                        } label: {
                        //                            Text("Marcar volumen 3 como leído")
                        //                                .frame(maxWidth: .infinity, alignment: .center)
                        //                        }
                        //                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8.0)
                            .fill(.regularMaterial)
                    }
                    .padding(.horizontal)
                }
                
                Button {
                    
                } label: {
                    Text(collectionData.setNextVolumeAsReadingLabel)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                .padding(.top, 8.0)
            } else {
                Button {
                    mangaViewModel.addMangaToCollection()
                } label: {
                    Text("Añadir a mi colección")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                .padding(.top, 8.0)
            }
        }
        .padding(.top)
        .onAppear {
            mangaViewModel.onAppear(modelContext: modelContext)
        }
    }
    
    var nbumero: Double {
        Double(mangaViewModel.collectionData?.volumesOwned.count ?? 0) / Double(mangaViewModel.manga.volumes)
    }
}

#Preview(traits: .sampleData) {
    MangaCollectionStatusView(mangaViewModel: .preview)
        .environment(CollectionViewModel(repository: .preview))
}
