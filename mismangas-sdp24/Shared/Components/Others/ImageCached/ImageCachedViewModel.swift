//
//  ImageCachedViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import SwiftUI

/// Modelo de vista para gestionar la carga y almacenamiento en caché de imágenes.
@Observable @MainActor
final class ImageCachedViewModel: Sendable {
    
    /// Gestor de descarga de imágenes compartido.
    private let imageDownloader = ImageDownloader.shared
    
    /// Imagen descargada y almacenada en caché.
    var image: UIImage?
    
    /// Recupera la imagen desde la caché local o la descarga si no está disponible.
    ///
    /// - Parameter url: URL de la imagen a cargar.
    func getImage(url: URL?) {
        guard let url else { return }
        let docURL = imageDownloader.urlDoc(url: url)
        if FileManager.default.fileExists(atPath: docURL.path()), let data = try? Data(contentsOf: docURL) {
            image = UIImage(data: data)
        } else {
            Task {
                await getImageAsync(url: url)
            }
        }
    }
    
    /// Descarga y almacena en caché una imagen de forma asíncrona.
    ///
    /// - Parameter url: URL de la imagen a descargar.
    @ImageDownloader
    func getImageAsync(url: URL?) async {
        guard let url else { return }
        
        do {
            let image = try await imageDownloader.image(from: url)
            await MainActor.run {
                self.image = image
            }
        } catch {
            print("Error recuperando imagen \(error)")
        }
    }
}
