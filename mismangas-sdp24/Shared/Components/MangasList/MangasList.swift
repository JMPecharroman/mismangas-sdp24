//
//  MangasList.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 22/12/24.
//

import SwiftUI

struct MangasList: View {
    
    let vm: MangasListViewModel
    
    var body: some View {
        List {
            MangasListContent(vm: vm)
        }
        .onAppear {
            vm.onAppear()
        }
    }
}

#Preview {
    MangasList(vm: MangasViewModel(repository: .preview))
}
