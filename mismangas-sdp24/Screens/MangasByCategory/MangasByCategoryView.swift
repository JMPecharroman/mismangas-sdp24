//
//  CategoryView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import SwiftUI

struct MangasByCategoryView: View {
    
    @State var vm: CategoryViewModel
    
    var body: some View {
        List {
            if !vm.isLoading && vm.mangas.isEmpty {
                ContentUnavailableView(
                    "Sin resultados",
                    systemImage: "xmark.circle",
                    description: Text("No se han encontrado mangas en la categoría \(vm.category.name)")
                )
            } else {
                ForEach(vm.mangas) { manga in
                    NavigationLink(value: manga) {
                        MangaListCell(manga: manga)
                    }
                }
                if vm.canLoadMore {
                    Text("Cargando más resultados...")
                }
            }
        }
        .navigationTitle(vm.category.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MangasByCategoryView(vm: .preview)
    }
}
