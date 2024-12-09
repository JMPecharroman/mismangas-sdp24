//
//  EndPoint.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

enum EndPoint {
    case listMangas(page: Int)
    
    var url: URL {
        switch self {
            case .listMangas(let page):
                    .apiProductionUrl.appendingPathComponent("list/mangas").appending(queryItems: [.page(page)])
        }
    }
}
