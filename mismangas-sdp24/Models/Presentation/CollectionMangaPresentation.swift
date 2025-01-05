//
//  CollectionMangaPresentation.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 2/1/25.
//

import Foundation

extension CollectionManga {
    
    var nextVolumeToRead: Int {
        (readingVolume ?? 0) + 1
    }
    
    var setNextVolumeAsReadingLabel: String {
        if nextVolumeToRead >= totalVolumes {
            return "Todos los volúmenes leídos"
        }
        if totalVolumes > 1 {
            return "Marcar volumen \(nextVolumeToRead) como leído"
        } else {
            return "Marcar como leído"
        }
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
    
    var volumesOwnedPercentage: Double {
        guard totalVolumes > 0 else { return 0.0 }
        
        return Double(volumesOwned.count) / Double(totalVolumes)
    }
    
    var volumesReadLabel: String {
        guard let readingVolume else {
            return "Sin empezar a leer"
        }
        
        return "\(readingVolume) volúmenes leídos"
    }
    
    var volumesReadPercentage: Double {
        guard totalVolumes > 0 else { return 0.0 }
        guard let readingVolume else { return 0.0 }
        
        return Double(readingVolume) / Double(totalVolumes)
    }
    
    var volumesToReadLabel: String {
        guard let readingVolume else {
            return "Sin empezar a leer"
        }
        
        if totalVolumes - readingVolume <= 0 {
            return "Todos los volúmenes leídos"
        }
        
        return "\(totalVolumes - readingVolume) volúmenes pendientes de leer"
    }
}
