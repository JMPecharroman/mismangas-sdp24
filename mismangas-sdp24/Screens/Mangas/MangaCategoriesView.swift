//
//  MangaCategoriesView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/12/24.
//

import SwiftUI

struct MangaCategoriesView: View {
    
    @State var vm: MangaViewModel
    
    var body: some View {
        List {
            Section("Categorías") {
                NavigationLink {
                    Text("Terror")
                } label: {
                    Text("Terror")
                }
            }
            Section("Temáticas") {
                NavigationLink {
                    Text("Terror")
                } label: {
                    Text("Terror")
                }
            }
            Section("Demografía") {
                NavigationLink {
                    Text("Terror")
                } label: {
                    Text("Terror")
                }
            }
        }
        .navigationTitle(vm.manga.title)
    }
}

#Preview {
    NavigationStack {
        MangaCategoriesView(vm: MangaViewModel(.preview))
    }
}
