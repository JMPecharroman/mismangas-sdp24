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
    @State var collectionViewModel = CollectionViewModel()
    @State var mangasViewModel = MangasViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authorsViewModel)
                .environment(categoriesViewModel)
                .environment(collectionViewModel)
                .environment(mangasViewModel)
        }
    }
}
