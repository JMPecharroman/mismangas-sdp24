//
//  CollectionMangaPresentation.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 2/1/25.
//

import Foundation

extension CollectionManga {
    
    var setNextVolumeAsReadingLabel: String {
        guard let readingVolume else {
             return "Marcar volumen 1 como leído"
        }
        
        return "Marcar volumen \(readingVolume + 1) como leído"
    }
    
    var volumesOwnedLabel: String {
        "\(volumesOwned.count)"
    }
}
