//
//  MangaStatus.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/12/24.
//


enum MangaStatus: Equatable, Hashable {
    case finished
    case onHiatus
    case publishing
    case unknown(String)
    
    init(rawValue: String) {
        switch rawValue.lowercased() {
            case "finished": self = .finished
            case "on_hiatus": self = .onHiatus
            case "currently_publishing": self = .publishing
            default:
                assertionFailure("MangaStatus invalid rawValue: \(rawValue)")
                self = .unknown(rawValue)
        }
    }
}
