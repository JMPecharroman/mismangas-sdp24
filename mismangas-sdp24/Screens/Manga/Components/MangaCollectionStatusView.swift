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
                                VStack(spacing: 16.0) {
                                    HStack {
                                        VStack {
                                            Text(manga.volumesLabel)
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
                                            Gauge(value: ownedGaugeValue) {
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
                            .buttonStyle(.plain)
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
    
    private var ownedGaugeValue: Double {
        Double(vm.data?.volumesOwned.count ?? 0) / Double(manga.volumes)
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
