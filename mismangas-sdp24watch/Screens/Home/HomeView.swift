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
                    FeaturedMangas()
                } label: {
                    Label(FeaturedMangas.viewTitle, systemImage: "star")
                }
                NavigationLink {
                    CollectionView()
                } label: {
                    Label(CollectionView.viewTitle, systemImage: "books.vertical")
                }
                NavigationLink {
                    AccountView()
                } label: {
                    Label(AccountView.viewTitle, systemImage: "person")
                }
            }
            .navigationTitle("Mis Mangas")
        }
    }
}

#Preview {
    HomeView()
}
