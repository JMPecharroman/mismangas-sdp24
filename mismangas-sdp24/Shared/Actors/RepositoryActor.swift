//
//  RepositoryActor.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

/// Actor encargado de gestionar el acceso a los repositorios de datos de la app.
///
/// `RepositoryActor` actúa como un actor global para garantizar el acceso concurrente seguro
/// a los repositorios de la aplicación, evitando problemas de concurrencia y asegurando que
/// las operaciones se ejecuten de manera secuencial cuando sea necesario.
@globalActor
actor RepositoryActor: GlobalActor {
    static let shared = RepositoryActor()
}
