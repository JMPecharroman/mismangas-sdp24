//
//  EndPoint.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 19/1/25.
//

import Foundation

protocol EndPoint {
    var url: URL { get }
    var body: Encodable? { get }
    var headers: [HeaderField] { get }
    var method: HTTPMethod { get }
}
