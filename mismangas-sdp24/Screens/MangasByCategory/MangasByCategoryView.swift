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
        MangasList(vm: vm)
            .navigationTitle(vm.category)
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MangasByCategoryView(vm: .preview)
    }
}
