//
//  ImageDownloader.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation
import UIKit

/// Descargador de imágenes en segundo plano con almacenamiento en caché.
///
/// `ImageDownloader` es un actor global que gestiona la descarga de imágenes desde una URL,
/// almacena las imágenes en caché y las guarda en el sistema de archivos en formato HEIC.
@globalActor
actor ImageDownloader {
    
    /// Instancia compartida de `ImageDownloader`.
    static let shared = ImageDownloader()
    
    /// Estado de la imagen en caché.
    private enum ImageStatus {
        /// La imagen está en proceso de descarga.
        case downloading(_ task: Task<UIImage, any Error>)
        /// La imagen ha sido descargada y está disponible en caché.
        case downloaded(_ image: UIImage)
    }
    
    /// Caché local de imágenes descargadas.
    private var cache: [URL: ImageStatus] = [:]
    
    /// Descarga una imagen desde una URL y la convierte en `UIImage`.
    ///
    /// - Parameter url: La URL desde donde se descargará la imagen.
    /// - Throws: Un error si la descarga o conversión falla.
    /// - Returns: La imagen descargada como `UIImage`.
    private func getImage(url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        return if let image = UIImage(data: data) {
            image
        } else {
            throw URLError(.badURL)
        }
    }
    
    /// Obtiene una imagen desde caché o la descarga si no está disponible.
    ///
    /// - Parameter url: La URL de la imagen a obtener.
    /// - Throws: Un error si la descarga falla.
    /// - Returns: La imagen descargada o recuperada desde caché.
    func image(from url: URL) async throws -> UIImage {
        if let status = cache[url] {
            return switch status {
            case .downloading(let task):
                try await task.value
            case .downloaded(let image):
                image
            }
        }
        
        let task = Task {
            try await getImage(url: url)
        }
        
        cache[url] = .downloading(task)
        
        do {
            let image = try await task.value
            cache[url] = .downloaded(image)
            try await saveImage(url: url)
            return image
        } catch {
            cache.removeValue(forKey: url)
            throw error
        }
    }
    
    /// Guarda la imagen en caché en formato HEIC.
    ///
    /// - Parameter url: La URL de la imagen a almacenar.
    /// - Throws: Un error si el guardado falla.
    private func saveImage(url: URL) async throws {
        guard let imageCached = cache[url] else { return }
        if case .downloaded(let image) = imageCached, let resized = await image.resizedImage(width: 300)?.heicData() {
            try resized.write(to: urlDoc(url: url), options: .atomic)
            cache.removeValue(forKey: url)
        }
    }
    
    /// Genera la URL local donde se almacenará la imagen en caché.
    ///
    /// - Parameter url: La URL original de la imagen.
    /// - Returns: La URL en la caché local con formato HEIC.
    nonisolated func urlDoc(url: URL) -> URL {
        let path = url.deletingPathExtension().appendingPathExtension("heic").lastPathComponent
        return URL.cachesDirectory.appending(path: path)
    }
}
