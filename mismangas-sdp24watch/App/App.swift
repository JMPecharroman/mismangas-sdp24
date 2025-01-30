//
//  mismangas_sdp24watchApp.swift
//  mismangas-sdp24watch
//
//  Created by José Mª Pecharromán on 25/1/25.
//

import SwiftUI

/// Aplicación principal de la versión para watchOS de **Mis Mangas**.
///
/// Esta estructura define el punto de entrada de la aplicación y gestiona el ciclo de vida de la app.
/// Se inicializan los `ViewModel` necesarios para la gestión de la colección de mangas,
/// sincronización de datos y la obtención de información de la API.
@main
struct MisMangasWatchApp: App {
    
    /// ViewModel que maneja la colección de mangas del usuario.
    @State var collectionViewModel = CollectionViewModel(repository: nil)
    
    /// ViewModel encargado de gestionar la obtención de mangas.
    @State var mangasViewModel = MangasViewModel()
    
    /// ViewModel responsable de la sincronización de datos entre el repositorio local y la API.
    @State var syncViewModel = SyncViewModel(repository: nil, repositoryNetwork: .api)
    
    var body: some Scene {
        WindowGroup {
            /// Vista principal de la aplicación.
            ContentView()
                .environment(collectionViewModel)
                .environment(mangasViewModel)
                .environment(syncViewModel)
        }
        /// Configuración del contenedor de modelos para la persistencia de datos.
        .modelContainer(for: CollectionMangaSD.self)
    }
}
