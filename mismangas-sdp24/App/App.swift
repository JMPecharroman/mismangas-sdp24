//
//  mismangas_sdp24App.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 3/12/24.
//

import SwiftUI

@main
struct MisMangasApp: App {
    
    @State var authorsViewModel = AuthorsViewModel()
    @State var categoriesViewModel = CategoriesViewModel()
    @State var collectionViewModel = CollectionViewModel(repository: nil)
    @State var mangasViewModel = MangasViewModel()
    @State var syncViewModel = SyncViewModel(repository: nil, repositoryNetwork: .api)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authorsViewModel)
                .environment(categoriesViewModel)
                .environment(collectionViewModel)
                .environment(mangasViewModel)
                .environment(syncViewModel)
        }
        .modelContainer(for: CollectionMangaSD.self)
    }
}
