//
//  UIImage.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import UIKit

extension UIImage {
    func resizedImage(width: CGFloat) async -> UIImage? {
        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                let scale = width / self.size.width
                let height = self.size.height * scale
                let newSize = CGSize(width: width, height: height)
                
                UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
                defer { UIGraphicsEndImageContext() }
                
                self.draw(in: CGRect(origin: .zero, size: newSize))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                
                continuation.resume(returning: resizedImage)
            }
        }
    }
}
