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
    
    var totalVolumesLabel: String {
        "\(totalVolumes) volúmenes"
    }
    
    var volumesOwnedLabel: String {
        if volumesOwned.isEmpty {
            return "Sin volúmenes comprados"
        }
        
        return "\(volumesOwned.count) volúmenes comprados"
    }
    
    var volumesOwnedCountLabel: String {
        "\(volumesOwned.count)"
    }
    
    var volumesReadLabel: String {
        guard let readingVolume else {
            return "Sin empezar a leer"
        }
        
        return "\(readingVolume) volúmenes leídos"
    }
}
