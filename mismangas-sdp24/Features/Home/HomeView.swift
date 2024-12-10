//
//  HomeView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import SwiftUI

struct HomeView: View {
    
    static let viewTitle: String = "Inicio"
    
    @State private var mangasVM = MangasViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading) {
                    SectionHeader(text: "Destacados")
                    if mangasVM.bestMangas.isEmpty {
                        VStack {
                            ProgressView()
                                .controlSize(.extraLarge)
                                .padding()
                        }
                        .frame(height: 225.0)
                        .frame(maxWidth: .infinity)
                    } else {
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 16.0) {
                                ForEach(mangasVM.bestMangas) { manga in
                                    ImageCached(url: manga.mainPictute)
                                        .scaledToFill()
                                        .frame(width: 150.0, height: 225.0)
                                        .background(.thinMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 4.0)
                            .padding(.bottom)
                        }
                        .scrollIndicators(.hidden)
                    }
                }
            }
            .navigationTitle(Self.viewTitle)
        }
    }
}

#Preview {
    TabView {
        HomeView()
            .tabItem {
                Label(HomeView.viewTitle, systemImage: "house")
            }
    }
}
