//
//  FeaturedMangas.swift
//  mismangas-sdp24watch Watch App
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import SwiftUI

struct FeaturedMangas: View {
    
    static let viewTitle: String = "Destacados"
    
    @Environment(MangasViewModel.self) private var vm
    
    var body: some View {
        List {
            ForEach(vm.bestMangas) { manga in
                NavigationLink {
                    MangaView(manga)
                } label:  {
                    FeaturedMangaListCell(manga: manga)
                }
            }
        }
        .navigationTitle(Self.viewTitle)
        .navigationBarTitleDisplayMode(.inline)
        .loading(vm.isLoadingMangas)
    }
}

#Preview {
    FeaturedMangas()
        .environment(MangasViewModel(repository: .preview))
}
