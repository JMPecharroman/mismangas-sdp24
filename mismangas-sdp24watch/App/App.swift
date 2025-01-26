//
//  mismangas_sdp24watchApp.swift
//  mismangas-sdp24watch
//
//  Created by José Mª Pecharromán on 25/1/25.
//

import SwiftUI

@main
struct MisMangasWatchApp: App {
    
    @State var collectionViewModel = CollectionViewModel(repository: nil)
    @State var mangasViewModel = MangasViewModel()
    @State var syncViewModel = SyncViewModel(repository: nil, repositoryNetwork: .api)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(collectionViewModel)
                .environment(mangasViewModel)
                .environment(syncViewModel)
        }
        .modelContainer(for: CollectionMangaSD.self)
    }
}
