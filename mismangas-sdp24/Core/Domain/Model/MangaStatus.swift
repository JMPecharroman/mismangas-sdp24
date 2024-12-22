//
//  MangaStatus.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/12/24.
//


enum MangaStatus: Equatable, Hashable {
    case discontinued
    case finished
    case onHiatus
    case publishing
    case unknown(String)
    
    init(rawValue: String) {
        switch rawValue.lowercased() {
            case "currently_publishing": self = .publishing
            case "discontinued": self = .discontinued
            case "on_hiatus": self = .onHiatus
            case "finished": self = .finished
            default:
                assertionFailure("MangaStatus invalid rawValue: \(rawValue)")
                self = .unknown(rawValue)
        }
    }
}
