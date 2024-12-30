//
//  CollectionRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 30/12/24.
//

import Foundation

struct CollectionRepositoryNetwork: CollectionRepository, NetworkInteractor, Sendable {
    var urlSession: URLSession
    
}

extension CollectionRepository where Self == CollectionRepositoryNetwork {
    static var api: CollectionRepository {
        CollectionRepositoryNetwork(urlSession: .shared)
    }
}
