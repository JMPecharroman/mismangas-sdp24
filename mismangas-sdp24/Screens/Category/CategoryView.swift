//
//  CategoryView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(CategoriesViewModel.self) private var vm
    
    let group: CategoryGroup
    
    var body: some View {
        List {
            if vm.items(for: group).isEmpty {
                NoResultsView()
            } else {
                ForEach(vm.items(for: group), id: \.self) { item in
                    NavigationLink {
                        MangasByCategoryView(item, group: group)
                    } label: {
                        Text(item)
                    }
                }
            }
        }
        .navigationTitle(group.label)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CategoryView(group: .genre)
        .environment(CategoriesViewModel(repository: .preview))
}
