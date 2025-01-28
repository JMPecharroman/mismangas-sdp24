//
//  Network.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import Foundation

struct Network: NetworkInteractor {
    var urlSession: URLSession { .shared }
}
