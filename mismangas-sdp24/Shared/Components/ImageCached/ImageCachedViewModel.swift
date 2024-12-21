//
//  ImageCachedViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import SwiftUI

@Observable @MainActor
final class ImageCachedViewModel: Sendable {
    private let imageDownloader = ImageDownloader.shared
    var image: UIImage?
    
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
