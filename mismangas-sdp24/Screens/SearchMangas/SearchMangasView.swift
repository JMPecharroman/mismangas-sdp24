//
//  SearchMangasView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 22/12/24.
//

import SwiftUI

struct SearchMangasView: View {
    
    static let viewTitle: String = "Buscar"
    
    @Environment(MangasViewModel.self) private var vm
    
    var body: some View {
        NavigationStack {
            MangasList(vm: vm)
                .navigationTitle(Self.viewTitle)
        }
    }
}

#Preview {
    SearchMangasView()
        .environment(MangasViewModel(repository: .preview))
}
