//
//  MangaView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 10/12/24.
//

import SwiftUI

struct MangaView: View {
    
    @State var vm: MangaViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 0.0) {
                MangaHeader(manga: vm.manga)
                    .padding(.bottom)

                LazyVStack(alignment: .leading) {
                    
                    SectionHeader(text: "Mi colección")
                        .padding(.horizontal)
                    VStack(spacing: 16.0) {
//                        Text("24 volúmenes")
//                            .fontWeight(.bold)
                        HStack {
//                            VStack {
//                                Gauge(value: 1.0) {
//                                    Text("Value")
//                                        .padding(.top, 10)
//                                        .frame(maxWidth: .infinity)
//                                } currentValueLabel: {
//                                    Text("12")
//                                }
//                                .gaugeStyle(.accessoryCircularCapacity)
//                                .tint(.red)
//                                Text("Volúmenes")
//                                    .foregroundStyle(.red)
//                                    .fontWeight(.semibold)
//                            }
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            Spacer()
                            VStack {
                                Text("1234")
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
                                Gauge(value: 0.3) {
                                    Text("Value")
                                } currentValueLabel: {
                                    Text("12")
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
                    
                    Button {
                        
                    } label: {
                        Text("Marcar volumen 3 como leído")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal)
                    .padding(.top, 8.0)
                    
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
