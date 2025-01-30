//
//  RepositoryError.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 2/1/25.
//

import Foundation

/// Errores asociados a la gestión del repositorio de datos.
enum RepositoryError: Error, LocalizedError {
    /// Valor de datos no válido.
    case dataValueNotValid
    
    /// Entidad no encontrada en el repositorio.
    case entityNotFound
    
    /// El contenedor del modelo no está configurado.
    case modelContainerNotSet
    
    /// El repositorio no ha sido inicializado correctamente.
    case notInitialized
}
