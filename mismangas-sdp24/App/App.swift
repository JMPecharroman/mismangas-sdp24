//
//  mismangas_sdp24App.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 3/12/24.
//

/// # MisMangasApp
/// La aplicación "Mis Mangas" es un proyecto académico desarrollado en SwiftUI
/// como parte del **Swift Developer Program 2024**.
///
/// ## Objetivo
/// La app permite gestionar una colección de mangas, permitiendo a los usuarios
/// explorar, filtrar, y organizar su biblioteca personal de mangas, integrando
/// datos de una API REST con más de 64,000 mangas publicados.
///
/// ## Arquitectura
/// La aplicación sigue una arquitectura **Clean Architecture**, donde se separan
/// responsabilidades mediante el uso de `ViewModel`s y repositorios para la gestión de datos.
///
/// ## Persistencia
/// La app utiliza `SwiftData` para almacenar la colección del usuario en local,
/// y sincroniza con la API cuando sea necesario.
///
/// ## Inyección de Dependencias
/// Se utiliza `.environment(_:)` para inyectar los `ViewModel`s en la jerarquía de vistas,
/// permitiendo que las vistas accedan a ellos de manera centralizada y desacoplada.
///
/// ## Autor
/// **José Mª Pecharromán** 

import SwiftUI

/// `MisMangasApp` es el punto de entrada principal de la aplicación.
///
/// La estructura sigue el protocolo `App`, que define el inicio del ciclo de vida.
@main
struct MisMangasApp: App {
    
    /// `authorsViewModel` gestiona los datos de los autores de mangas.
    @State var authorsViewModel = AuthorsViewModel()
    
    /// `categoriesViewModel` maneja las categorías y géneros de los mangas.
    @State var categoriesViewModel = CategoriesViewModel()
    
    /// `collectionViewModel` administra la colección de mangas del usuario.
    /// Se inicializa con un repositorio que permite la persistencia de los datos.
    @State var collectionViewModel = CollectionViewModel(repository: nil)
    
    /// `mangasViewModel` gestiona la recuperación y visualización de mangas desde la API.
    @State var mangasViewModel = MangasViewModel()
    
    /// `syncViewModel` permite la sincronización entre la colección local y la API.
    /// Se inicializa con un repositorio de red para obtener los datos.
    @State var syncViewModel = SyncViewModel(repository: nil, repositoryNetwork: .api)
    
    /// `body` define la escena principal de la aplicación.
    ///
    /// Se encapsula dentro de un `WindowGroup`, que define la estructura de la UI de la app.
    /// Además, se inyectan los `ViewModel`s en el entorno para que las vistas los consuman.
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
