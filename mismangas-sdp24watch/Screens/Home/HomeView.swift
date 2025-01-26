//
//  HomeView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    CollectionView()
                } label: {
                    Label(CollectionView.viewTitle, systemImage: "books.vertical")
                }
            }
            .navigationTitle("Mis Mangas")
        }
    }
}

#Preview {
    HomeView()
}
